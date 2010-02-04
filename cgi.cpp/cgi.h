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
 * $Id: cgi.h,v 1.8 2010/02/04 12:51:40 cepek Exp $ 
 */

#ifndef cgi_h___SQLTUTOR_CGI_H___sqltutor_cgi_h
#define cgi_h___SQLTUTOR_CGI_H___sqltutor_cgi_h

#include <map>
#include <list>
#include <string>
#include <iostream>


/** \mainpage CGI C++ classes
 *
 * This is a brief description of a set of C++ CGI classes used in <a
 * href="http://www.gnu.org/software/sqltutor">GNU Sqltutor</a>
 * project.
 */
  

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
    
    virtual void run_elist();
    
    // list of pointers to child elements
    Elist elements;
    
    // pointers to internal objects created on the free store
    static Elist dlist;

    friend class Element;
  };
  

  Element(Element_* e) : element_(e) { Element_::dlist.push_back(e); } 
  Element_* element_;
};



/** \brief HTML element object with attributes.
 *
 *  Base abstract class thar adds attributes to Element class.
 */

class ElementAttributes : public Element {
public:

  ElementAttributes& operator += (std::string s)
  {
    add_attr(s);
    return *this;
  }

  ElementAttributes& add_attr(std::string s)
  {
    static_cast<ElementAttributes_*>(element_)->add_attr(s);
    return *this;
  }

protected:  

  class ElementAttributes_ : public Element_ {
  public:
    ElementAttributes_() {}
    ElementAttributes_(const char* t) : attr(t) {}
    ElementAttributes_(std::string t) : attr(t) {}

    ElementAttributes_& add_attr(std::string s)
    {
      attr += " " + s;
      return *this;
    }

    std::string attr;
  };

  ElementAttributes(Element_* e) : Element(e) {}

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



/** \brief Implementation of HTML \<FORM\> tag.
 */

class Form : public ElementAttributes {

  class Form_ : public ElementAttributes_ {
  public:
    Form_(std::string a, std::string m="post", std::string x="") 
      : ElementAttributes_(x), action(a), method(m) {}
    void run();
    
  private:
    std::string action;
    std::string method;
  };

public:

  Form(std::string act, std::string meth="post", std::string atr="") 
    : ElementAttributes(new Form_(act, meth, atr)) {}
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
    std::string size_;

    std::string string() const;
  };
  
  Inp_* inp_;

public:

  Input& value(std::string s)  {inp_->val_(s);   return *this; }
  Input& src  (std::string s)  {inp_->src_ = s;  return *this; }
  Input& alt  (std::string s)  {inp_->alt_ = s;  return *this; }
  Input& disabled(bool t=true) {inp_->dis_ = t?"disabled" : ""; return *this; }
  Input& checked (bool t=true) {inp_->chk_ = t?"checked"  : ""; return *this; }
  Input& size (unsigned int n);
  
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



/** \brief Implementation of \<INPUT type='reset' ... \> tag.
 */

class InputReset : public Input {
public:
  InputReset(std::string name) : Input("reset", name) {}
};



/** \brief Implementation of simplified \<TABLE\> tag.
 *
 * The number of table columns must be explicitly defined as the first
 * constructor parameter.
 *
 * Example:
 *\code
 * void Demo::dbg_info()
 * {
 *   Table tab(2, "border='1'");
 * 
 *   tab.caption("dbg info ..." );
 *   tab.th("attribute");
 *   tab.th("value");
 *
 *   for (CGI::Map::const_iterator m=CGI::map.begin(), e=CGI::map.end(); m!=e; m++)
 *     {
 *       tab << m->first 
 *           << m->second;
 *     }
 * 
 *   cgi << tab;
 * }\endcode
 */

class Table : public ElementAttributes {

  class Table_ : public ElementAttributes_ {
  public:
    Table_(int cols, std::string atts) : ElementAttributes_(atts), cols_(cols) {}

    void caption(std::string c) { caption_ = c;     }
    void th     (std::string h) { th_.push_back(h); }
    void td     (std::string h) { td_.push_back(h); }

    void run();
    void run_elist();

  private:
    int         cols_;
    std::string caption_;
    std::list<std::string> th_;
    std::list<std::string> td_;
  };

  Table_* table_;

public:

  Table(int cols=1, std::string atts="") 
  : ElementAttributes(new Table_(cols,atts)) 
  {
    table_ = static_cast<Table_*>(element_);
  }

  void caption(std::string c) { table_->caption(c); }
  void th     (std::string h) { table_->th(h);      }
  void td     (std::string h) { table_->td(h);      }
};



/** \brief Implementation of the base class Tag with a single
 *  protected constructor.
 */

class Tag : public ElementAttributes {

  class Tag_ : public ElementAttributes_ {
  public:
    
    void run();
    
    Tag_(std::string t) : type_(t) {}

    std::string type_;
  };
  
protected:
  
  Tag(std::string t) : ElementAttributes(new Tag_(t)) {}
  
};



/** \brief Implementation of \<H1> tag.
 */

class H1 : public Tag {
public:
  H1() : Tag("h1") {}
  H1(std::string a) : Tag("h1") { add_attr(a); }
};



/** \brief Implementation of \<H2> tag.
 */

class H2 : public Tag {
public:
  H2() : Tag("h2") {}
  H2(std::string a) : Tag("h2") { add_attr(a); }
};



/** \brief Implementation of \<H3> tag.
 */

class H3 : public Tag {
public:
  H3() : Tag("h3") {}
  H3(std::string a) : Tag("h3") { add_attr(a); }
};



/** \brief Implementation of \<H4> tag.
 */

class H4 : public Tag {
public:
  H4() : Tag("h4") {}
  H4(std::string a) : Tag("h4") { add_attr(a); }
};



/** \brief Implementation of \<H5> tag.
 */

class H5 : public Tag {
public:
  H5() : Tag("h1") {}
  H5(std::string a) : Tag("h1") { add_attr(a); }
};



/** \brief Implementation of \<H1> tag.
 */

class H6 : public Tag {
public:
  H6() : Tag("h5") {}
  H6(std::string a) : Tag("h5") { add_attr(a); }
};



/** \brief Implementation of the \<STRONG> tag
 */

class Strong : public Tag {
public:
  Strong() : Tag("strong") {}
  Strong(std::string a) : Tag("strong") { add_attr(a); }
};



/** \brief Implementation of the \<EM> tag
 */

class Em : public Tag {
public:
  Em() : Tag("em") {}
  Em(std::string a) : Tag("em") { add_attr(a); }
};


/** \brief Implemention of HTML \<P\> tag.
 *
 *  Par class implements HTML \<p\> tag. Par objects can be constracted
 *  before insertion into another CGI container. Text parameters of
 *  constructor are inserted as Text objects.
 */

class Par : public Tag {
public:
  Par() : Tag("p") {}
  Par(std::string a) : Tag("p") { add_attr(a); }
};



/** \brief Implemention of HTML \<DIV\> tag.
 */

class Div : public Tag {
public:
  Div() : Tag("div") {}
  Div(std::string a) : Tag("div") { add_attr(a); }
};



/** \brief Implemention of HTML \<SPAN\> tag.
 */

class Span : public Tag {
public:
  Span() : Tag("span") {}
  Span(std::string a) : Tag("span") { add_attr(a); }
};



/** \brief  Implemention of HTML \<PRE\> tag.
  */
 
class Pre : public Tag {
public:
  Pre() : Tag("pre") {}
  Pre(std::string a) : Tag("pre") { add_attr(a); }
};



/** \brief  Implemention of HTML \<TEXTAREA\> tag.
  */
 
class TextArea : public ElementAttributes {

  class TextArea_ : public ElementAttributes_ {
  public:
    TextArea_(std::string name, int rows, int cols) : 
      name_(name), rows_(rows), cols_(cols)
    {
    }

    void run();
    TextArea_& val_(std::string t) { text_ = t; return *this; }

  private:
    std::string name_;
    int         rows_;
    int         cols_;
    std::string text_;
  };

  TextArea_* textarea_;

public:

  TextArea(std::string name, int rows, int cols) 
    : ElementAttributes(new TextArea_(name, rows, cols))
  {
    textarea_ = static_cast<TextArea_*>(element_);
  }

  TextArea& value(std::string text) { textarea_->val_(text); return *this; }
};



/** \brief  Implementation of HTML tag \<OPTION\> (see Select)
  */

class Option : public Tag {
public:
    Option(std::string value, std::string description) : Tag("option")
    {
        add_attr("value='" + value + "'");
        *this << description;
    }
};


/** \brief  Implementation of HTML tag \<OPTGROUP\> (see Select)
  */

class Optgroup : public Tag {
public:
  Optgroup(std::string label) : Tag("optgroup")
  {
      add_attr("label='" + label + "'");
  }
};



/** \brief  Implementation of HTML tag \<SELECT\>
  *
  * Example:
  *\code
  *   Select   cities("city");
  *   Optgroup europe("Europe");
  *   europe    << Option("1", "London") << Option("2", "Paris")
  *             << Option("3", "Rome") << Option("4", "Berlin") << Option("5", "Prague");
  *   Optgroup america("North America");
  *   namerica  << Option("6", "New York") << Option("7", "Washington")
  *             << Option("8", "San Francisco") << Option("9", "Vancouver");
  *   Optgroup australia("Australia");
  *   australia << Option("10", "Sydney") << Option("11", "Adelaide")
  *             << Option("12", "Perth");
  *   cities  << europe << namerica << australia;\endcode
  */

class Select : public Tag {
public:
  Select(std::string name) : Tag("select")
  {
      add_attr("name='" + name + "'");
  }
};


#endif
