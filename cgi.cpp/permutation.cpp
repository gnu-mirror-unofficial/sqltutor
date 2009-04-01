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
 * $Id: permutation.cpp,v 1.3 2009/04/01 18:12:38 cepek Exp $ 
 */

#include "permutation.h"


void Permutation::reset(int size)
{
  N = std::max(size, 0);
  perm.resize(N);
  total = N;
  int t = N;
    while (--t > 1) total *= t;
    avail = total;
    for (int i=0; i<N; i++) perm[i] = i;
}


void Permutation::next()
{
  if (avail) avail--;
  if (avail == 0) return;
  
  int i = N - 1;
  while (perm[i-1] >= perm[i]) i--;
  int j = N;
  while (perm[j-1] <= perm[i-1]) j--;
  
  std::swap(perm[i-1], perm[j-1]);    
  
  i++; j = N;
  while (i < j)
    {
      std::swap(perm[i-1], perm[j-1]);
      i++;
      j--;
    }
}
