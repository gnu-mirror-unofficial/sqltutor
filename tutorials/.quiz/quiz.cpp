#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <cstring>


class Quiz
{
public:
  Quiz(const char* file, const char*);

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
  const std::string tutorial_label;
  typedef std::vector<std::string> Rows;    // nonempty lines
  Rows rows;                        
  typedef std::vector<int> Pars;            // paragraph index
  Pars pars;
  int blocks_;

  bool        isempty(const std::string& line) const;
  std::string sql(int, const char* str) const;
};


Quiz::Quiz(const char* file, const char* label) 
  : input_file_name(file), tutorial_label(label)
{
  std::ifstream inp(input_file_name);
  std::string   line;  

  blocks_ = 0;
  int  line_count = 0;
  bool previous, current = true, comment = false;  

  while(std::getline(inp, line))
    {
      /* recursive comments are not handled */

      const int E = line.size();
      const int D = E - 1;
      char  ccur = '\0', cpre;

      for (int i=0; i<E; i++)
        {
          cpre = ccur;
          ccur  = line[i];
          if (comment)
            {
              line[i] = ' ';
              if (ccur == '/' && cpre == '*') comment = false;
            }
          else
            {
              if (ccur == '/' && i < D && line[i+1] == '*')
                {
                  comment = true;
                  line[i] = ' ';
                }
            }
        }


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

  ostr << 
    "BEGIN;\n\n"
    "SET search_path TO sqltutor;\n\n"
    "CREATE TEMPORARY TABLE xxx (\n"
    "   tutorial_id int\n"
    ");\n\n"
    "INSERT INTO xxx SELECT tutorial_id FROM tutorials WHERE label='"
    +  tutorial_label + "';\n\n";

  for (int b=0; b<blocks();)
    if (block_type(b) == SQL)
      {
        std::string id = sql_id(b);

        ostr << "INSERT INTO questions "
             << "(id, tutorial_id, dataset, points, question) SELECT "
             << id << ", tutorial_id, "
             << "'" << sql_dataset (b) << "',"
             << " " << sql_points  (b) << ","
             << " " << sql_text    (b) << " FROM xxx;\n";

        {
          using std::string;
          string category;
          const string& categories = sql_categories(b) + "|";
          
          for (string::const_iterator 
                 i=categories.begin(), e=categories.end(); i!=e; ++i)
            if (*i == '|')
              {
                ostr << "SELECT merge_category(" 
                     << "(SELECT tutorial_id FROM xxx), " 
                     << id << ", '"+category+"');\n"; 
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
            ostr << "INSERT INTO answers "
                 << "(tutorial_id, question_id, priority, answer) "
                 << "SELECT tutorial_id, " << id << ", " 
                 << priority++  << ", "
                 << sql_text(b) << " FROM xxx;\n";
            b++;
          }
      }
  ostr << 
    "DROP TABLE xxx;\n"
    "COMMIT;\n\n";

  return ostr;
}

std::string Quiz::sql_text(int index) const
{
  const std::string& block = block_text(index);
  const std::string sqlstr = "'";
  std::string sql = sqlstr;
  
  for (int i=0; i<block.length(); i++)
    {
      char c = block[i];
      
      // switch(c)
      //   {
      //   case '\n':
      //   case '\'': 
      //   case '\"': sql += '\\';
      //   }
      if (c == '\'') sql += c;

      sql += c;
    }

  sql += sqlstr;
  
  return sql;
}

int main(int argc, char* argv[])
{
  std::cerr << "\ntutorial     : " << argv[1] << std::endl;
  for (int i=2; i<argc; i++)
    {
      std::cerr << "reading file : " << argv[i] << std::endl;

      Quiz quiz(argv[i], argv[1]);
      quiz.write_sql(std::cout);
    }
}
