dnl $Id$
dnl config.m4 for extension my_ext

dnl Comments in this file start with the string 'dnl'.
dnl Remove where necessary. This file will not work
dnl without editing.

dnl If your extension references something external, use with:

dnl PHP_ARG_WITH(my_ext, for my_ext support,
dnl Make sure that the comment is aligned:
dnl [  --with-my_ext             Include my_ext support])

dnl Otherwise use enable:

PHP_ARG_ENABLE(my_ext, whether to enable my_ext support,
Make sure that the comment is aligned:
[  --enable-my_ext           Enable my_ext support])

if test "$PHP_MY_EXT" != "no"; then
  dnl Write more examples of tests here...

  dnl # --with-my_ext -> check with-path
  dnl SEARCH_PATH="/usr/local /usr"     # you might want to change this
  dnl SEARCH_FOR="/include/my_ext.h"  # you most likely want to change this
  dnl if test -r $PHP_MY_EXT/$SEARCH_FOR; then # path given as parameter
  dnl   MY_EXT_DIR=$PHP_MY_EXT
  dnl else # search default path list
  dnl   AC_MSG_CHECKING([for my_ext files in default path])
  dnl   for i in $SEARCH_PATH ; do
  dnl     if test -r $i/$SEARCH_FOR; then
  dnl       MY_EXT_DIR=$i
  dnl       AC_MSG_RESULT(found in $i)
  dnl     fi
  dnl   done
  dnl fi
  dnl
  dnl if test -z "$MY_EXT_DIR"; then
  dnl   AC_MSG_RESULT([not found])
  dnl   AC_MSG_ERROR([Please reinstall the my_ext distribution])
  dnl fi

  MY_LIB_DIR=/home/vagrant/my_lib
  INCLUDE_DIR=$MY_LIB_DIR
  PHP_LIBDIR=$MY_LIB_DIR

  AC_CHECK_HEADER([$INCLUDE_DIR/my_lib.h],
    [],
    [AC_MSG_ERROR(["$INCLUDE_DIR/my_lib.h" が見つかりません])]
  )
  PHP_ADD_INCLUDE($INCLUDE_DIR)

  # --with-my_ext -> add include path
  PHP_ADD_INCLUDE($MY_EXT_DIR/include)

  # --with-my_ext -> check for lib and symbol presence
  LIBNAME=my_lib
  LIBSYMBOL=my_echo_int

  PHP_CHECK_LIBRARY($LIBNAME,$LIBSYMBOL,
  [
    PHP_ADD_LIBRARY_WITH_PATH($LIBNAME, $MY_EXT_DIR/$PHP_LIBDIR, MY_EXT_SHARED_LIBADD)
    AC_DEFINE(HAVE_MY_EXTLIB,1,[ ])
  ],[
    AC_MSG_ERROR([libmy_lib.so が見つからないか、バージョンが誤っています])
  ],[
    -L$MY_EXT_DIR/$PHP_LIBDIR -lm
  ])
  
  PHP_SUBST(MY_EXT_SHARED_LIBADD)

  PHP_NEW_EXTENSION(my_ext, my_ext.c, $ext_shared,, -DZEND_ENABLE_STATIC_TSRMLS_CACHE=1)
fi
