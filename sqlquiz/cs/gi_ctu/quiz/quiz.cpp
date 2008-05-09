#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <cctype>

class Quiz
{
public:
  Quiz(const char* file);

  enum { TEXT, SQL };

  int           blocks() const;
  std::string   block_text(int) const;
  int           block_type(int) const;
  std::string   sql_id        (int i) const { return sql(i, "id"      ); }
  std::string   sql_dataset   (int i) const { return sql(i, "dataset" ); }
  std::string   sql_categories(int i) const { return sql(i, "category"); }
  std::string   sql_points    (int i) const { return sql(i, "points"  ); }
  std::string   sql_text      (int i) const;
  std::ostream& write_sql(std::ostream&) const;

private:

  const char* input_file_name;
  typedef std::vector<std::string> Rows;    // nonempty lines
  Rows rows;                        
  typedef std::vector<int> Pars;            // paragraph index
  Pars pars;
  int blocks_;

  bool        isempty(const std::string& line) const;
  std::string sql(int, const char* str) const;
};

Quiz::Quiz(const char* file) : input_file_name(file)
{
  std::ifstream inp(input_file_name);
  std::string   line;  

  blocks_ = 0;
  int  line_count = 0;
  bool previous, current = true;  

  while(std::getline(inp, line))
    {
      previous = current;
      current  = isempty(line);
      if (current) continue;

      if (!current && previous)
        {
          pars.push_back( line_count );
          blocks_++;
        }
      rows.push_back(line);
      line_count++;
    }
  pars.push_back(line_count);
}


bool Quiz::isempty(const std::string& line) const
{
  if (line.length() > 0 && line[0] == '#') return true;

  for (int i=0; i<line.length(); i++)
    if (!std::isspace(line[i]))
      {
        return false;
      }

  return true;
}


int Quiz::blocks() const
{
  return pars.size()-1;
}


std::string Quiz::block_text(int index) const
{
  const int t = block_type(index);
  std::string str;

  if (t == TEXT)
    for (int i=pars[index]; i<pars[index+1]; i++) 
      {
        str += rows[i] + '\n';
      }
  else if (t == SQL)
    {
      const int n = rows[pars[index]+1].length();     
      std::string q = rows[pars[index]+1].substr( std::min(3,n) );
      if (!isempty(q)) str += q + '\n';

      for (int i=pars[index]+2; i<pars[index+1]; i++)
        {
          const int n = rows[i].length();
          std::string s = rows[i].substr( std::min(3, n) );
          str += s + '\n';
        }
    }
  return str;
}


int Quiz::block_type(int index) const
{
  const std::string& row = rows[pars[index]];

  if (row.length() >= 2 && row.substr(0,2) == "--") return SQL;

  return TEXT;
}


std::string Quiz::sql(int index, const char* keyword) const
{
  std::string key;

  if (block_type(index) == SQL)
    {
      const std::string& str = rows[pars[index]];
      const int N = str.length();
      size_t n = str.find(keyword);
      if (n != std::string::npos)
        {
          n += std::strlen(keyword);
          while (n < N && std::isspace(str[n])) n++;
          if (str[n] != '=') return key;
          n++;
          while (n < N && std::isspace(str[n])) n++;
          if (str[n] != '"' && str[n] != '\'') return key;
          n++;
          while (n < N && str[n] != '"' && str[n] != '"')
            {
              key += str[n++];
            }
        }
    }

  return key;
}


std::ostream& Quiz::write_sql(std::ostream& ostr) const
{
  ostr << "--\n"
       << "-- generated from input file : " << input_file_name << "\n"
       << "--\n\n";

  ostr << "BEGIN;\n";
  for (int b=0; b<blocks();)
    if (block_type(b) == SQL)
      {
        std::string id = sql_id(b);

        ostr << "INSERT INTO questions "
             << "(id, dataset, points, question) VALUES ("
             << " " << id << ", "
             << "'" << sql_dataset (b) << "', "
             << " " << sql_points  (b) << ","
             << "'" << sql_text    (b) << "'"
             << " );\n";

        {
          using std::string;
          string category;
          const string& categories = sql_categories(b) + "|";
          
          for (string::const_iterator 
                 i=categories.begin(), e=categories.end(); i!=e; ++i)
            if (*i == '|')
              {
                ostr << "SELECT merge_category("+id +", '"+category+"');\n"; 
                category.clear();
              }
            else
              {
                category += *i;
              }
        }

        b++;

        int priority = 1;
        while (b<blocks() && block_type(b) == TEXT)
          {
            ostr << "INSERT INTO answers (question_id, priority, answer) "
                 << "VALUES ( " << id << ", " 
                 << priority++  << ", '"
                 << sql_text(b) << "'"
                 << " );\n";
            b++;
          }
      }
  ostr << "COMMIT;\n\n";

  return ostr;
}

std::string Quiz::sql_text(int index) const
{
  const std::string& block = block_text(index);
  std::string sql;
  
  for (int i=0; i<block.length(); i++)
    {
      char c = block[i];
      
      switch(c)
        {
        case '\n':
        case '\'': 
        case '\"': sql += '\\';
        }
      
      sql += c;
    }

  return sql;
}

int main(int argc, char* argv[])
{
  for (int i=1; i<argc; i++)
    {
      std::cerr << "reading file : " << argv[i] << std::endl;

      Quiz quiz(argv[i]);
      quiz.write_sql(std::cout);
    }
}
