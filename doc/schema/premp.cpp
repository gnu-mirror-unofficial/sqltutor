#include <iostream>
#include <cctype>
#include <string>
#include <vector>
#include <map>
#include <queue>
#include <sstream>

using std::cin;
using std::cout;
using std::isalpha;
using std::isspace;
using std::string;
using std::vector;


class Schema {
public:

  Schema();

private:

  struct SQLtable
  {
    string x;
    string y;
    string w;
    vector<string> attribute;
  };
  
  std::map<string, SQLtable> table;
  std::queue<char>           queue;
  char                       bs;

  void sqlbox();
  bool getchar(char& c);
  void push(const std::ostringstream&);
};


Schema::Schema() : bs(0)
{
  char  c;
  while (getchar(c)) cout.put(c);
}


bool Schema::getchar(char& c)
{
  if (!queue.empty())
    {
      c = queue.front();
      queue.pop();
      return true;
    }

  if (bs == 0)
      cin.get(c);
  else
    {
      c = bs;
      bs = 0;
      return true;
    }

  if (c == '_')
    {
      bs = c;
      c  = '\\';
    }

  if (c == '#') 
    {
      sqlbox();
      getchar(c);
    }
  
  return cin;
}


void Schema::push(const std::ostringstream& ostr)
{
  const string& s = ostr.str();
  for (size_t i=0; i<s.length(); i++)
    {
      queue.push(s[i]);
    }
}

void Schema::sqlbox()
{
  char c;
  
  string name;
  while (getchar(c) && (isalpha(c) || c=='\\' || c=='_')) name += c;
  cin.putback(c);
  
  std::map<string, SQLtable>::iterator iter = table.find(name);
  if (iter == table.end())
    {
      /* initial definition of the box is simply written to std::cout */

      SQLtable t;
      
      t.attribute.push_back(name);
      
        while (getchar(c) && c != ',' && c != ';') 
        if (!isspace(c))
          t.x += c;
      
      while (getchar(c) && c != ',' && c != ';') 
        if (!isspace(c))
          t.y += c;
      
      while (getchar(c) && c != ',' && c != ';') 
        if (!isspace(c))
          t.w += c;
      
      while (c != ';')
        {
          string a;
          
          while (getchar(c) && c != ',' && c != ';') 
            if (!isspace(c))
              a += c;
          
          t.attribute.push_back(a);
        }
      
      table[name] = t;
      
      cout 
        << "fill (" << t.x << "," << t.y << ")--(" 
        << t.x << "," << t.y << ")+(" << t.w << ", 0)--(" 
        << t.x << "," << t.y << ")+(" << t.w << ",-th)"
        << " --(" << t.x << "," << t.y 
        << ")+(0,-th)--cycle withcolor 0.9 white;\n";
      
      const size_t N = t.attribute.size();
      
      for (size_t i=0; i<N; i++)
        {
          cout
            << "label.rt(btex " << t.attribute[i] << " etex, ("
            << t.x << ", " << t.y << "-" << i << "*th - th/2));\n";
        }
      
      for (size_t i=0; i<=N; i++)
        {
          cout 
            << "draw (" << t.x << "," << t.y 
            << "-" << i << "th)"
            << "--(" << t.x << "+" << t.w << "," << t.y 
            << "-" << i << "th);\n";
          
          if (i==1) i = N-1;
        }
      
      cout 
        << "draw (" << t.x << "," << t.y << ")--("
        << t.x << "," << t.y << "-" << N << "*th);\n";
      
      cout 
        << "draw (" << t.x << "+" << t.w << "," << t.y << ")--("
        << t.x << "+" << t.w << "," << t.y << "-" << N << "*th);\n";
    }
  else
    {
      /* previously defined objects must be written through the queue */

      std::ostringstream cout;

      SQLtable t = iter->second;
      size_t   N = t.attribute.size();
      
      char f;
      getchar(c);
      getchar(f);


      switch (f)
        {
        case 'l':
          cout << "(" << t.x << ")";
          return push(cout);
        case 'r':
          cout << "(" << t.x << "+" << t.w << ")";
          return push(cout);
        case 't':
          cout << "(" << t.y << ")";
          return push(cout);
        case 'b':
          cout << "(" << t.y << "-" << N << "*th)";
          return push(cout);
        }


      string par;
      while (getchar(c) && c != '(');
      while (getchar(c) && c != ')') par += c;
      
      switch (f)
        {
        case 'w': 
          cout << "(" << t.x << "," 
               << t.y << "-" << par << "*th - th/2)";
          return push(cout);
        case 'e': ;
          cout << "(" << t.x << "+tw," 
               << t.y << "-" << par << "*th - th/2)";
          return push(cout);
        case 'W': 
          cout << "draw "
               << "(" << t.x << "," 
               << t.y << "-" << par << "*th - th/2+er)--"
               << "(" << t.x << "-er,"
               << t.y << "-" << par << "*th - th/2)--"
               << "(" << t.x << ","
               << t.y << "-" << par << "*th - th/2-er);\n";
          return push(cout);
        case 'E':
          cout << "draw "
               <<  "(" << t.x << "+" << t.w << "," 
               << t.y << "-" << par << "*th - th/2+er)--"
               << "(" << t.x << "+" << t.w << "+er,"
               << t.y << "-" << par << "*th - th/2)--"
               << "(" << t.x << "+" << t.w << ","
               << t.y << "-" << par << "*th - th/2-er);\n";
          return push(cout);
        case 's':
          cout << "(" << t.x << "+" << par << "*tw," << t.y 
               << "-" << N << "*th)";
          return push(cout);
        case 'n':
          cout << "(" << t.x << "+" << par << "*tw," << t.y << ")";
          return push(cout);
        case 'S':
          cout << "draw "
               << "(" << t.x << "+" << par << "*tw-er," 
               << t.y << "-" << N << "*th)--"
               << "(" << t.x << "+" << par << "*tw,"    
               << t.y << "-" << N << "*th-er)--"
               << "(" << t.x << "+" << par << "*tw+er," 
               << t.y << "-" << N << "*th);\n";
          return push(cout);
        case 'N':
          cout << "draw "
               << "(" << t.x << "+" << par << "*tw-er," << t.y << ")--"
               << "(" << t.x << "+" << par << "*tw,"    << t.y << "+er)--"
               << "(" << t.x << "+" << par << "*tw+er," << t.y << ");\n";
          return push(cout);
        } 
    }
}


int main()
{
  Schema s;
}




