#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.
#
AC_PREREQ(2.61)
AC_INIT([sqltutor], [0.04.94], [cepek@gnu.org])
AC_CONFIG_SRCDIR([sqltutor/sqltutor.cpp])
AC_CONFIG_HEADER([sqltutor/config.h])
AC_CONFIG_AUX_DIR([sqltutor/config.aux])

AM_INIT_AUTOMAKE


# C macro definitions and environment variables for the SQLtutor database

AC_SUBST([SQLTUTOR_DATABASE],  [sqltutor] )
AC_SUBST([SQLTUTOR_WWW_USER],  [sqlquiz]  )
AC_SUBST([SQLTUTOR_PASSWORD],  [sqlkrok]  )
AC_SUBST([SQLTUTOR_WWW_EXEC],  [sqlexec]  )
AC_SUBST([SQLTUTOR_PASSEXEC],  [sqlkrok]  )

AC_DEFINE_UNQUOTED([SQLTUTOR_DATABASE], [$SQLTUTOR_DATABASE], [SQLtutor database name])
AC_DEFINE_UNQUOTED([SQLTUTOR_WWW_USER], [$SQLTUTOR_WWW_USER], [SQLtutor web/cgi  user name])
AC_DEFINE_UNQUOTED([SQLTUTOR_PASSWORD], [$SQLTUTOR_PASSWORD], [SQLtutor web/cgi  user password])
AC_DEFINE_UNQUOTED([SQLTUTOR_WWW_EXEC], [$SQLTUTOR_WWW_EXEC], [SQLtutor user/sql user name])
AC_DEFINE_UNQUOTED([SQLTUTOR_PASSEXEC], [$SQLTUTOR_PASSEXEC], [SQLtutor user/sql user password])


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
           database/Makefile
           tutorials/.quiz/Makefile
           tutorials/Makefile
           tutorials/cs.sqltutor/Makefile
           tutorials/en.sqlzoo/Makefile
           datasets/Makefile
           datasets/cs.filmy/Makefile
           datasets/cs.letadla/Makefile
           datasets/cs.pracoviste/Makefile
           datasets/cs.premyslovci/Makefile
           datasets/cs.staty/Makefile
           datasets/cs.tramvaje/Makefile
           datasets/cs.unesco/Makefile
           datasets/cs.vodocty/Makefile
           datasets/en.bbc/Makefile
           datasets/en.busses/Makefile
           datasets/en.countries/Makefile
           datasets/en.movies/Makefile
           datasets/en.neeps/Makefile
           datasets/en.nobel/Makefile
           doc/Makefile
          ])

