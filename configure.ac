#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.
#
AC_PREREQ(2.61)
AC_INIT([sqltutor], [0.04.90], [cepek@gnu.org])
AC_CONFIG_SRCDIR([sqltutor/sqltutor.cpp])
AC_CONFIG_HEADER([sqltutor/config.h])
AC_CONFIG_AUX_DIR([sqltutor/config.aux])

AM_INIT_AUTOMAKE

# Environment variables for SQLtutor database
AC_SUBST(SQLTUTOR_DATABASE, sqlquiz)
AC_SUBST(SQLTUTOR_WWW_USER, wwwquiz)

# Checks for programs.
AC_PROG_AWK
AC_PROG_CXX
AC_PROG_CC
AC_PROG_CPP
AC_PROG_LN_S
AC_PROG_MAKE_SET
AC_PROG_RANLIB

# Checks for libraries.
AC_CHECK_LIB([pqxx], [main])

PKG_CHECK_MODULES([LIBPQXX], [libpqxx >= 2.6.8])
AC_SUBST(LIBPQXX_CFLAGS)
AC_SUBST(LIBPQXX_LIBS)

# Checks for typedefs, structures, and compiler characteristics.
AC_HEADER_STAT
AC_HEADER_STDBOOL
AC_C_CONST
AC_C_INLINE
AC_TYPE_OFF_T
AC_TYPE_SIZE_T

# Checks for library functions.
AC_FUNC_ERROR_AT_LINE
AC_FUNC_MALLOC
AC_FUNC_MEMCMP
AC_FUNC_MMAP
AC_FUNC_REALLOC
AC_FUNC_SETVBUF_REVERSED
AC_CHECK_FUNCS([memmove memset munmap pow sqrt])

AC_OUTPUT([Makefile 
           sqltutor/Makefile
           sqltutor/quiz/Makefile 
           sqltutor/sql/Makefile
           database/Makefile
           tutorials/.quiz/Makefile
           tutorials/Makefile
           datasets/Makefile
          ])
