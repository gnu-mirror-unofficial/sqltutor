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

#ifndef Permutation_h__PERMUTATION_H__Permutation_H__
#define Permutation_h__PERMUTATION_H__Permutation_H__

#include <vector>
#include <algorithm>


class Permutation {
public:

  Permutation() : N(0), avail(0), total(0) {}
  Permutation(int k)     { reset(k);        }

  void next();
  void reset(int size);

  int  size () const     { return N;        }
  int  perms() const     { return total;    }
  bool empty() const     { return avail==0; }
  int& operator[](int i) { return perm[i];  }

private:
  int N; 
  std::vector<int> perm;
  int avail;
  int total;
};

#endif
