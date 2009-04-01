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

/* 
 * $Id: cgi.h,v 1.7 2009/04/01 18:12:37 cepek Exp $ 
 */

#ifndef cgi_h___SQLTUTOR_CGI_H___sqltutor_cgi_h
#define cgi_h___SQLTUTOR_CGI_H___sqltutor_cgi_h

#include <map>
#include <list>
#include <string>
#include <iostream>

  
/** \brief Base abstract HTML element class.
 *
 * Base abstract element class is a sequential container of HTML
 * element objects.
 */


class Element {
public:

  virtual ~Element() {}

  Element& operator << (const Element& element);
  Element& operator << (const char*    text);
  Element& operator << (std::string    text);
  Element& operator << (int            num);

protected:

  class Element_ {
  public:
    
    Element_() {};
    virtual ~Element_() {}
    
    /** Write the object to the HTML/CGI output page.
     *
     * Each derived class must call private method run_elist() to
     * trigger sequential processing all objects (FROM elements,
     * strings, numbers) stored in the container.
     */
    virtual void run() = 0;
        
  protected:
    
    typedef std::list<Element_*> Elist;
    
    void run_elist();
    
    // list of pointers to child elements
    Elist elements;
    
    // pointers to internal objects created on free store
    static Elist dlist;

    friend class Element;
  };
  

  Element(Element_* e) : element_(e) { Element_::dlist.push_back(e); } 
  Element_* element_;
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
 *   CGI cgi;
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

  class CGI_ : public Element_ {
  public:
    
    /** CGI_ is a singleton class, the only way to create the CGI_
     *  instance is by calling the static CGI_::instance() member
     *  function.
     */
    
    static CGI_* instance();
        
    /** Write HTML object tree.
     *
     *  All internal dynamically created objects are freed by the
     *  run() member function.
     */
    
    void run();
    
    /** Set the page title (HTML tag \<TITLE\>) */
    void set_title(std::string t)  { title_ = t; }
    
    /** Container with attribute/value pairs (CGI variables). 
     *
     * The contianer is implicitly initialised by the CGI_() constructor.
     */
    
  protected:
    
    /** Protected constructor ensures that only one instance can ever
     *  get created.
     */
    
    CGI_();
    
  private:
    
    static CGI_*  instance_;
    Elist         cgi_elist;
    std::string   title_;
    friend class  Form;
  };

  CGI_* cgi_;
  friend class  Element;
  
public:

  CGI() : Element( CGI_::instance() ) { cgi_ = CGI_::instance(); }
  void run()                          { cgi_->run(); }
  void set_title(std::string t)       { cgi_->set_title(t); }

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
  static  std::string getenv(const char* env);

  typedef std::map <std::string, std::string>  Map;
  static  Map  map;
};



/** \brief HTML text/string element
 *
 *  String helper objects are inserted into CGI element containers, but
 *  cannot contain other elements.
 */

class String : Element {

  class String_ : public Element_ {
  public:
    String_() {}
    String_(const char* t) : text(t) {}
    String_(std::string t) : text(t) {}
    void run();
    
  private:
    std::string text;
  };

  friend class Element;

public:

  String() : Element(new String_) {}
  String(const char* t) : Element(new String_(t)) {}
  String(std::string t) : Element(new String_(t)) {}
   
};



/** \brief Implemention of HTML \<P\> tag.
 *
 *  Par class implements HTML \<p\> tag. Par objects can be constracted
 *  before insertion into another CGI container. Text parameters of
 *  constructor are inserted as Text objects.
 */

class Par : public Element {

  class Par_ : public Element_ {
  public:
    Par_() {}
    Par_(const char* t) : attr(t) {}
    Par_(std::string t) : attr(t) {}
    void run();
  private:
    std::string attr;
  };

public:
  
  Par()              : Element(new Par_   ) {}
  Par(const char* t) : Element(new Par_(t)) {}
  Par(std::string t) : Element(new Par_(t)) {}  
};



/** \brief Implemention of HTML \<DIV\> tag.
 */

class Div : public Element {

  class Div_ : public Element_ {
  public:
    Div_() {}
    Div_(const char* t) : attr(t) {}
    Div_(std::string t) : attr(t) {}
    void run();
  private:
    std::string attr;
  };

public:
  
  Div()              : Element(new Div_   ) {}
  Div(const char* t) : Element(new Div_(t)) {}
  Div(std::string t) : Element(new Div_(t)) {}  
};



/** \brief Implemention of HTML \<SPAN\> tag.
 */

class Span : public Element {

  class Span_ : public Element_ {
  public:
    Span_() {}
    Span_(const char* t) : attr(t) {}
    Span_(std::string t) : attr(t) {}
    void run();
  private:
    std::string attr;
  };

public:
  
  Span()              : Element(new Span_   ) {}
  Span(const char* t) : Element(new Span_(t)) {}
  Span(std::string t) : Element(new Span_(t)) {}  
};



/** \brief  Implemention of HTML \<PRE\> tag.
  */
 
class Pre : public Element {

  class Pre_ : public Element_ {
  public:
    Pre_() {}
    Pre_(const char* t) : attr(t) {}
    Pre_(std::string t) : attr(t) {}
    void run();
  private:
    std::string attr;
  };

public:
  
  Pre()              : Element(new Pre_   ) {}
  Pre(const char* t) : Element(new Pre_(t)) {}
  Pre(std::string t) : Element(new Pre_(t)) {}  
};



/** \brief Implementation of HTML \<FORM\> tag.
 */

class Form : public Element {

  class Form_ : public Element_ {
  public:
    Form_(std::string a, std::string m="post", std::string x="") 
      : action(a), method(m), attr(x) {}
    void run();
    
  private:
    std::string action;
    std::string method;
    std::string attr;
  };

public:

  Form(std::string act, std::string meth="post", std::string atr="") 
    : Element(new Form_(act, meth, atr)) {}
};



/** \brief Implementation of HTML \<INPUT\> tag.
 *
 *  Constructor Input::Input(std::string t, std::string n) is
 *  protected, only derived classes can be instantiated.
 */

class Input : public Element {

  class Inp_ : public Element_ {
  public:
    
    void run();
    
    void val_(std::string s);
    
    Inp_(std::string t, std::string n) : type_(t), name_(n) {}
    
    std::string type_;
    std::string name_;
    std::string value_;
    std::string src_;
    std::string alt_;
    std::string dis_;
    std::string chk_;  

    std::string string() const;
  };
  
  Inp_* inp_;

public:

  Input& value(std::string s)  {inp_->val_(s);  return *this; }
  Input& src  (std::string s)  {inp_->src_= s;  return *this; }
  Input& alt  (std::string s)  {inp_->alt_= s;  return *this; }
  Input& disabled(bool t=true) {inp_->dis_= t?"disabled" : ""; return *this; }
  Input& checked (bool t=true) {inp_->chk_= t?"checked"  : ""; return *this; }
  
protected:

  Input(std::string t, std::string n) : Element(new Inp_(t, n)) 
  {
    inp_ = static_cast<Inp_*>(element_);
  }

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



#endif
