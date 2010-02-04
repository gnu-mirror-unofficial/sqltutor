/* 
   This file is part of GNU Sqltutor
   Copyright (C) 2008  Free Software Foundation, Inc.
   Contributed by Ales Cepek <cepek@gnu.org>
 
   GNU Sqltutor is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   GNU Sqltutor is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with GNU Sqltutor.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "cgi.h"
#include <sstream>
#include <cstdlib>

Element::Element_::Elist Element::Element_::dlist;
CGI::Map    CGI::map;
CGI::CGI_*  CGI::CGI_::instance_ = 0;


CGI::CGI_* CGI::CGI_::instance() 
{
  if (instance_ == 0) 
    {
      instance_ = new CGI_;
    }
  return instance_;
}


std::string CGI::getenv(const char* env)
{
  // get the environments of the OS (or empty string if not available)
  const char* s = std::getenv(env);
  return s ? std::string(s) : std::string("");
}


CGI::CGI_::CGI_()
{
  using std::cin;

  char        c;
  std::string atr, val;
  while (cin >> c)
    {
      cin.putback(c);

      atr = "";     // attribute/value pair  (atr=val&);
      val = "";

      int  ix1, ix2;
      char c, x1, x2;
      while (cin.get(c))
        {
          if (c == '=') break;
          atr += c;
        }
      while (cin.get(c))
        {
          if (c == '&') break;
          if (c == '+')
            c = ' ';
          else if (c == '%')
            {
              cin.get(x1);
              cin.get(x2);
              ix1 = x1 >= 'A' ? int(x1) - int('A') + 10 : int(x1) - int('0');
              ix2 = x2 >= 'A' ? int(x2) - int('A') + 10 : int(x2) - int('0');
              c = char(16*ix1 + ix2);
            }
          val += c;
        }

      map[atr] = val;
    }
}


void CGI::CGI_::run()
{
  std::cout  <<
    "Content-Type: text/html\n"
    "\n"
    "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
    "<!DOCTYPE html\n"
    "     PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"\n"
    "     \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n"
    "<html xmlns=\"http://www.w3.org/1999/xhtml\"" 
    " xml:lang=\"en\" lang=\"en\">\n"
    "  <head>\n"
    "    <meta content=\"text/html; charset=UTF-8\" "
    "http-equiv=\"Content-Type\" />\n"
    "    <title>" << title_ << "</title>\n"
    "  </head>\n"
    "<body>\n"
    "\n";

  run_elist();

  std::cout <<
    "</body>\n"
    "</html>\n";

  for (Elist::iterator e=dlist.end(), b=dlist.begin(); b!=e; b++)    
    {
      Element_* d = *b;
      if (d != instance_)
        delete d;
    }
  dlist.clear();
}


void Element::Element_::run_elist()
{
  for (Elist::iterator e=elements.end(), b=elements.begin(); b!=e; b++) 
    (*b)->run();
}


Element& Element::operator << (const Element& e)
{
  element_->elements.push_back(e.element_);
  return *this;
}


Element& Element::operator << (const char* text)
{
  String* t = new String(text);
  element_->elements.push_back(t->element_);
  return *this;
}


Element& Element::operator << (std::string text)
{
  String* t = new String(text);
  element_->elements.push_back(t->element_);
  return *this;
}


Element& Element::operator << (int num)
{
  std::ostringstream ostr;
  ostr << num;
  String* t = new String(ostr.str());
  element_->elements.push_back(t->element_);
  return *this;
}


void String::String_::run()
{
  std::cout << text;
}


void Form::Form_::run()
{
  std::cout << "<form action='" << action 
            << "' method='" << method << "' " << attr << ">\n";
  run_elist();
  std::cout << "</form>\n";
}


void Input::Inp_::val_(std::string s)
{
  value_="";
  for (size_t i=0; i<s.length(); i++)
    switch (s[i])
      {
      case '\'': value_ += "&apos;"; break;
      default  : value_ += s[i];
      }
}


Input& Input::size(unsigned int n)
{
  std::ostringstream ostr;
  ostr << n;
  inp_->size_ = ostr.str();
  
  return *this;
}


std::string Input::Inp_::string() const
{
  std::string str("<input");

  if (!type_ .empty()) str += " type='"  + type_  + "'";
  if (!name_ .empty()) str += " name='"  + name_  + "'";
  if (!value_.empty()) str += " value='" + value_ + "'";
  if (!src_  .empty()) str += " src='"   + src_   + "'";
  if (!alt_  .empty()) str += " alt='"   + type_  + "'";
  if (!size_ .empty()) str += " size='"  + size_  + "'";
  if (!dis_  .empty()) str += " "        + dis_   + " ";
  if (!chk_  .empty()) str += " "        + chk_   + " ";

  str += " />";

  return str;
}


void Input::Inp_::run()
{
  std::cout << this->string();
}


void Table::Table_::run()
{
  std::cout << "<table " + attr + ">\n";
  run_elist();
  std::cout << "</table>\n";
}


void Table::Table_::run_elist()
{
  if (!caption_.empty())
    {
      std::cout << "<caption>" + caption_ + "</caption>\n";
    }

  if (!th_.empty())
    {
      std::cout << "<tr>\n";
      for (std::list<std::string>::const_iterator 
             e=th_.end(), b=th_.begin(); b!=e; b++)
        {
          std::cout << "<th>" + *b + "</th>";
        }
      std::cout << "</tr>\n";
    }

  for (Elist::iterator e=elements.end(), b=elements.begin(); b!=e;)
    { 
      std::cout << "<tr>\n";
      std::list<std::string>::const_iterator atr = td_.begin();
      for (int c=0; c<cols_ && b!=e; c++, b++)
        {
          std::cout << "<td ";
          if (atr != td_.end()) std::cout << *atr++ ;
          std::cout << ">";
          (*b)->run();
          std::cout << "</td>";
        }
      std::cout << "</tr>\n";
    }
}


void Tag::Tag_::run()
{
  std::cout << "<"  + type_ + attr + ">";
  run_elist();
  std::cout << "</" + type_ + ">\n";
}


void TextArea::TextArea_::run()
{
  std::cout << "<textarea name='" << name_
            << "' rows='" << rows_ << "' cols='" << cols_ << "'>\n";
  // run_elist();
  std::cout << text_;
  std::cout << "</textarea>\n";
}
