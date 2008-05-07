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
 * $Id: cgi.h,v 1.1 2008/05/07 15:27:34 cepek Exp $ 
 */

#ifndef cgi_h___SQLTUTOR_CGI_H___sqltutor_cgi_h
#define cgi_h___SQLTUTOR_CGI_H___sqltutor_cgi_h

#include <map>
#include <list>
#include <string>
#include <iostream>

  class Input;
  
  class Element {
  public:
    
    Element();
    virtual ~Element() {}
    virtual void run() = 0;
    Element& operator << (Element& element);
    Element& operator << (Input&   input);
    Element& operator << (const char*    text);
    Element& operator << (std::string    text);
    Element& operator << (unsigned int    num);
    
  protected:
    
    typedef std::list<Element*>            Elist;
    
    void run_elist();
    
    // list of pointers to child elements
    Elist* elements;
    Elist elist;
    
    // pointers to internal objects created on free store, must be
    // explicitly deleted by CGI
    static Elist dlist;
  };
  
  
  
  class Text : public Element {
  public:
    Text(const char* t) : text(t) {}
    Text(std::string t) : text(t) {}
    void run() { std::cout << text; }
    
  private:
    std::string text;
  };
  
  
  
  class Par : public Element {
  public:
    Par() {}
    Par(const char* t) { *this << t; }
    Par(std::string t) { *this << t; }
    void run();
  };
  
  
  
  class Pre : public Element {
  public:
    Pre() {}
    Pre(const char* t) { *this << t; }
    Pre(std::string t) { *this << t; }
    void run();
  };
  
  
  class Input : public Element {
  public:
    Input() {}
    Input(std::string t) { type(t); }
    void run();
    
    Input& type (std::string s) { itype =s; return *this; }
    Input& name (std::string s) { iname =s; return *this; }
    Input& value(std::string s);
    Input& src  (std::string s) { isrc  =s; return *this; }
    Input& alt  (std::string s) { ialt  =s; return *this; }
    Input& disabled()  { idis = "disabled"; return *this; } 
    
  private:
    std::string itype;
    std::string iname;
    std::string ivalue;
    std::string isrc;
    std::string ialt;
    std::string idis;
    
    friend class Element;
    friend class Form;
    std::string string() const;
  };
  
  class CGI : public Element {
  public:

    ~CGI();

    void init();
    void init(std::string t) { init(); set_title(t); }
    void run();
    void set_title(std::string t);
    
    typedef std::map <std::string, std::string>  CGImap;
    static CGImap        map;
    static std::string getenv(const char* env);
    
  protected:
    
    static int         instances;
    static Elist       cgi_elist;
    static std::string title;
    
    friend class Form;
  };
  
  
  
  class Form : public Element {
  public:
    Form(std::string a, std::string m="post") : action(a), method(m) {}
    void run();
    
  private:
    std::string action;
    std::string method;
    std::string attributes;
  };
  

#endif
