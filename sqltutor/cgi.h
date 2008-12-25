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
 * $Id: cgi.h,v 1.3 2008/12/25 15:29:18 cepek Exp $ 
 */

#ifndef cgi_h___SQLTUTOR_CGI_H___sqltutor_cgi_h
#define cgi_h___SQLTUTOR_CGI_H___sqltutor_cgi_h

#include <map>
#include <list>
#include <string>
#include <iostream>

class Input;

  
/** Base abstract FORM element class.
 *
 * Base abstract FORM element class is a sequential container 
 * of FORM element objects. 
 */

class Element {
public:
  
  Element();
  virtual ~Element() {}
  
  /** Write the object to the HTML/CGI output page.
   *
   * Each derived class must call private method run_elist() to
   * trigger sequential processing all objects (FROM elements,
   * strings, numbers) stored in the container.
   */
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



/** Text helper objects are inserted into CGI element containers, but
 *  cannot contain other elements.
 */
   
class Text : public Element {
public:
  Text(const char* t) : text(t) {}
  Text(std::string t) : text(t) {}
  void run() { std::cout << text; }
  
private:
  std::string text;
};



/** Par class implements HTML \<p\> tag. Par objects can be constracted
 *  before insertion into another CGI container. Text parameters of
 *  constructor are inserted as Text objects.
 */

class Par : public Element {
public:
  Par() {}
  Par(const char* t) { *this << t; }
  Par(std::string t) { *this << t; }
  void run();
};



/** Pre class implements HTML /<pre/> tag.
 */

class Pre : public Element {
public:
  Pre() {}
  Pre(const char* t) { *this << t; }
  Pre(std::string t) { *this << t; }
  void run();
};



/** Implementation of HTML \<INPUT\> tag.
 */

class Input : public Element {
public:
  Input() {}
  Input(std::string t) { type(t); }
  void run();
  
  Input& value(std::string s);
  Input& type (std::string s)  { type_ = s; return *this; }
  Input& name (std::string s)  { name_ = s; return *this; }
  Input& src  (std::string s)  { src_  = s; return *this; }
  Input& alt  (std::string s)  { alt_  = s; return *this; }
  Input& disabled(bool t=true) { dis_ = t ? "disabled": ""; return *this; } 
  Input& checked (bool t=true) { chk_ = t ? "checked" : ""; return *this; } 
  
private:
  std::string type_;
  std::string name_;
  std::string value_;
  std::string src_;
  std::string alt_;
  std::string dis_;
  std::string chk_;
  
  friend class Element;
  friend class Form;
  std::string string() const;
};



/** Common Gateway Interface (CGI) class.
 *
 * All HTML objects must be inserted into a single CGI object. HTML page is
 * created by calling its run() method.
 *
 * CGI variables (information to the HTTP server) are send only by the
 * POST method. The GET method is currently not supported by the CGI
 * class.
 *
 * Example:
 *\code
 * #include "cgi.h"
 *
 * int main()
 * {
 *   CGI cgi;
 *   cgi.set_title("Simple CGI Demo");
 * 
 *   // read CGI variables
 *   cgi.init();
 *   std::string hdn = CGI::map["hdn"];
 * 
 *   Par p1;  
 *   p1 << "Some text ... " << hdn ;
 * 
 *   // constructor parameter: name of the CGI script to be run on submit 
 *   Form f1("demo");    
 *   f1 << Input().type("submit");
 * 
 *   Par p2;
 *   int n = hdn.length();
 *   if (n == 1)
 *     p2 << "Submit button pressed once";
 *   if (n == 2)
 *     p2 << "Submit button pressed twice";
 *   else if (n > 2)
 *     p2 << "Submit button pressed " << n << " times";
 * 
 *   // change the value of 'hdn' variable
 *   hdn += "*";
 *   // send CGI variable hdn to "demo" CGI script using a named hidden field
 *   f1 << Input().type("hidden").name("hdn").value(hdn);
 * 
 *   cgi << p1 << f1  << p2;
 * 
 *   cgi.run();
 * }\endcode
 *
 * TODO: CGI should be singleton.
 */

class CGI : public Element {
public:
  
  ~CGI();
  
  /** Init() reads CGI variables, attribute/value pairs, into the
   *  CGImap container.
   * 
   * This method must be called explicitly.
   */
  
  void init();
  
  /** Calls init() and set_title() to set the page title. */
  void init(std::string t) { init(); set_title(t); }
  void run();
  
  /** Set the page title (HTML tag \<title\>) */
  void set_title(std::string t);
  
  /** Container with attribute/value pairs (CGI variables). 
   *
   * Must be explicitly initialized by calling init().
   */
  
  typedef std::map <std::string, std::string>  Map;
  static Map map;
  
  /** Static method returns CGI environment (CGI Scope) variable or
   *  empty string if not available. 
   *
   * Examples of some CGI environment variables:
   * - SERVER_SOFTWARE
   * - SERVER_NAME
   * - GATEWAY_INTERFACE
   * - SERVER_PROTOCOL
   * - SERVER_PORT
   * - REQUEST_METHOD
   * - PATH_INFO
   * - PATH_TRANSLATED
   * - SCRIPT_NAME
   * - QUERY_STRING
   * - REMOTE_HOST
   * - REMOTE_ADDR
   * - AUTH_TYPE
   * - REMOTE_USER
   * - REMOTE_IDENT
   * - CONTENT_TYPE
   * - CONTENT_LENGTH
   */
  static std::string getenv(const char* env);
  
protected:
  
  static int         instances;
  static Elist       cgi_elist;
  static std::string title;
  
  friend class Form;
};



/** Implementation of HTML \<FORM\> tag.
 */

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
