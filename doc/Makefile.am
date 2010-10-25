## Process this file with automake to produce Makefile.in -*-Makefile-*-
## Copyright (C) 2008 Ales Cepek

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

AM_MAKEINFOFLAGS  = --no-split
noinst_TEXINFOS     = sqltutor.texi
sqltutor_TEXINFOS = intro.texi concepts.texi install.texi internals.texi \
                    gpl-3.0.texi fdl.texi

EXTRA_DIST = \
   sqltutor-dialog-1.eps \
   sqltutor-dialog-1.pdf \
   sqltutor-dialog-1.png \
   sqltutor-dialog-2.eps \
   sqltutor-dialog-2.pdf \
   sqltutor-dialog-2.png \
   sqltutor-dialog-3.eps \
   sqltutor-dialog-3.pdf \
   sqltutor-dialog-3.png 


CLEANFILES =
CLEANDIRS  =

# Doxygen section dopted from bison-2.4/doc/Makefile.am

## -------------- ##      
## Doxygenation.  ##
## -------------- ##

DOXYGEN = doxygen

.PHONY: doc html

doc: html

doxygen: Doxyfile
	$(DOXYGEN)

edit = sed -e 's,@PACKAGE_NAME\@,$(PACKAGE_NAME),g' \
           -e 's,@PACKAGE_VERSION\@,$(PACKAGE_VERSION),g' \
           -e 's,@top_builddir\@,$(top_builddir),g' \
           -e 's,@top_srcdir\@,$(top_srcdir),g'

EXTRA_DIST += Doxyfile.in
CLEANFILES += Doxyfile
# Sed is used to generate Doxyfile from Doxyfile.in instead of
# configure, because the former is way faster than the latter.
Doxyfile: $(srcdir)/Doxyfile.in
	$(edit) $(srcdir)/Doxyfile.in >Doxyfile

CLEANDIRS += html latex

