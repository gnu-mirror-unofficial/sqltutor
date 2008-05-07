/* 
   This file is a part of SQLtutor
   Copyright (C) 2008  Ales Cepek <cepek@gnu.org>
 
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

/* 
 * $Id: cgi.cpp,v 1.1 2008/05/07 15:27:33 cepek Exp $ 
 */

#include <iostream>
#include <cstdlib>
#include <cctype>
#include <sstream>
#include "cgi.h"

using std::cout;
using std::endl;


Element::Elist Element::dlist;
int            CGI::instances = 0;
Element::Elist CGI::cgi_elist;
std::string    CGI::title;
CGI::CGImap    CGI::map;

Element::Element()
{
  elements = &elist;
}

void Element::run_elist()
{
  for (Elist::iterator e=elements->end(), b=elements->begin(); b!=e; b++) 
    (*b)->run();
}

Element& Element::operator << (Element& e)
{
  elements->push_back(&e);
  return *this;
}

Element& Element::operator << (Input& input)
{
  *this << input.string();
  return *this;
}

Element& Element::operator << (const char* text)
{
  Text* t = new Text(text);
  dlist.push_back(t);
  return (*this << *t);
}

Element& Element::operator << (std::string text)
{
  Text* t = new Text(text);
  dlist.push_back(t);
  return (*this << *t);
}

Element& Element::operator << (unsigned int num)
{
  std::ostringstream ostr;
  ostr << num;
  Text* t = new Text(ostr.str());
  dlist.push_back(t);
  return (*this << *t);
}

void Par::run()
{
  cout << "<p>";
  run_elist();
  cout << "</p>";
}

void Pre::run()
{
  cout << "<pre>";
  run_elist();
  cout << "</pre>";
}

void Form::run()
{
  cout << "<form action='" << action << "' method='" << method << "'>";
  cout << "<fieldset style=\"display: none\">";
  for (CGI::CGImap::iterator i=CGI::map.begin(); i!=CGI::map.end(); ++i)
    {
      const std::string& att = (*i).first;
      const std::string& val = (*i).second;

      for (size_t i=0; i<val.length(); i++)
        if (!std::isspace(val[i]))
          {
            cout << Input().type("hidden").name(att).value(val).string();
            break;
          }
    }
  cout << "</fieldset>";

  run_elist();

  cout << "</form>";  
}

std::string Input::string() const
{
  std::string str("<input");

  if (!itype .empty()) str += " type='"  + itype  + "'";
  if (!iname .empty()) str += " name='"  + iname  + "'";
  if (!ivalue.empty()) str += " value='" + ivalue + "'";
  if (!isrc  .empty()) str += " src='"   + isrc   + "'";
  if (!ialt  .empty()) str += " alt='"   + itype  + "'";
  if (!idis  .empty()) str += " "        + idis   + " ";

  str += " />";

  return str;
}

void Input::run()
{
  cout << this->string();
}

Input& Input::value(std::string s)
{
  ivalue="";
  for (int i=0; i<s.length(); i++)
    switch (s[i])
      {
      case '\'': ivalue += "&apos;"; break;
      default  : ivalue += s[i];
      }
  return *this;
}

CGI::~CGI()
{
  --instances;
  if (instances == 0)
    for (Elist::const_iterator e=dlist.end(), b=dlist.begin(); b!=e; b++) 
      delete (*b);
}

void CGI::init()
{
  using std::cin;

  elements = &cgi_elist; 
  instances++;

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

void CGI::run()
{
  cout  <<
    "Content-Type: text/html\n"
    "\n"
    "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
    "<!DOCTYPE html\n"
    "     PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"\n"
    "     \"DTD/xhtml1-strict.dtd\">\n"
    // "<!DOCTYPE html"
    // " PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\""
    // " \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n"
    "<html xmlns=\"http://www.w3.org/1999/xhtml\"" 
    " xml:lang=\"en\" lang=\"en\">\n"
    "  <head>\n"
    "    <meta content=\"text/html; charset=UTF-8\" http-equiv=\"Content-Type\" />\n"
    "    <title>" << title << "</title>\n"
    "  </head>\n"
    "<body>\n"
    "\n";

  run_elist();

  cout <<
    "</body>\n"
    "</html>\n";
}

void CGI::set_title(std::string t)
{
  title = t;
}

std::string CGI::getenv(const char* env)
{
  // get the environments of the OS (or empty string if not available)
  const char* s = std::getenv(env);
  return s ? std::string(s) : std::string("");
}

