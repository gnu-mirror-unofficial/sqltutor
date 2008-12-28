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
 * $Id: cgi.h,v 1.3 2008/12/28 14:17:25 cepek Exp $ 
 */

#ifndef cgi_h___SQLTUTOR_CGI_H___sqltutor_cgi_h
#define cgi_h___SQLTUTOR_CGI_H___sqltutor_cgi_h

#include <map>
#include <list>
#include <string>
#include <iostream>

class Input;

  
/** \brief Base abstract HTML element class.
 *
 * Base abstract element class is a sequential container of HTML
 * element objects.
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
  Elist  elist;
  
  // pointers to internal objects created on free store, must be
  // explicitly deleted by CGI if necessary
  static Elist dlist;
};



/** \brief HTML text/string element
 *
 *  Text helper objects are inserted into CGI element containers, but
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



/** \brief Implemention of HTML \<p\> tag.
 *
 *  Par class implements HTML \<p\> tag. Par objects can be constracted
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



/** \brief  Implemention of HTML \<pre\> tag.
 */

class Pre : public Element {
public:
  Pre() {}
  Pre(const char* t) { *this << t; }
  Pre(std::string t) { *this << t; }
  void run();
};



/** \brief Implementation of HTML \<INPUT\> tag.
 *
 *  Constructor Input::Input(std::string t, std::string n) is
 *  protected so that only derived classes can be instantiated.
 */

class Input : public Element {
public:

  void run();
  
  Input& value(std::string s);
  Input& src  (std::string s)  { src_  = s; return *this; }
  Input& alt  (std::string s)  { alt_  = s; return *this; }
  Input& disabled(bool t=true) { dis_ = t ? "disabled": ""; return *this; } 
  Input& checked (bool t=true) { chk_ = t ? "checked" : ""; return *this; } 
  
protected:
  Input(std::string t, std::string n) : type_(t), name_(n) {}

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



/** \brief Implementation of \<INPUT type='submit' ... \> tag.
 */

class InputSubmit : public Input {
public:
  InputSubmit(std::string name) : Input("submit", name) {}
};



/** \brief Implementation of \<INPUT type='text' ... \> tag.
 */

class InputText : public Input {
public:
  InputText(std::string name) : Input("text", name) {}
};



/** \brief Implementation of \<INPUT type='password' ... \> tag.
 */

class InputPassword : public Input {
public:
  InputPassword(std::string name) : Input("password", name) {}
};



/** \brief Implementation of \<INPUT type='checkbox' ... \> tag.
 */

class InputCheckbox : public Input {
public:
  InputCheckbox(std::string name) : Input("checkbox", name) {}
};



/** \brief Implementation of \<INPUT type='hidden' ... \> tag.
 */

class InputHidden : public Input {
public:
  InputHidden(std::string name) : Input("hidden", name) {}
};



/** \brief Common Gateway Interface class.
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
 *   CGI& cgi = * CGI::instance();
 *   cgi.set_title("Simple CGI Demo");
 * 
 *   std::string hdn = CGI::map["hdn"];
 * 
 *   Par p1;  
 *   p1 << "Some text ... " << hdn ;
 * 
 *   // constructor parameter: name of the CGI script to be run on submit 
 *   Form f1("demo");    
 *   f1 << InputSubmit("sbmt");
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
 *   f1 << InputHidden("hdn").value(hdn);
 * 
 *   cgi << p1 << f1  << p2;
 * 
 *   cgi.run();
 * }\endcode
 */

class CGI : public Element {
public:

  /** CGI is a singleton class, the only way to create the CGI
   *  instance is by calling the static CGI::instance() member
   *  function.
   */

  static CGI* instance();
  
  /** Destructor deletes all element objects created on free store. If
   *  necessary the destructor must be called explicitly (normally not
   *  needed).
   */

  ~CGI();
  
  /** Write HTML object tree.
   */
  
  void run();
  
  /** Set the page title (HTML tag \<title\>) */
  void set_title(std::string t);
  
  /** Container with attribute/value pairs (CGI variables). 
   *
   * The contianer is implicitly initialised by the CGI() constructor.
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
  
  /** Protected constructor ensures that only one instance can ever
   *  get created.
   */

  CGI();

private:

  static CGI*  instance_;
  Elist        cgi_elist;
  std::string  title;
  friend class Form;
};



/** \brief Implementation of HTML \<FORM\> tag.
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
