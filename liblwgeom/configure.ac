AC_PREREQ(2.61)

AC_INIT([liblwgeom], [2.3.3])

: ${R_HOME=`R RHOME`}
if test -z "${R_HOME}"; then
  AC_MSG_ERROR([Could not determine R_HOME.])
fi

AC_MSG_NOTICE([R_HOME: ${R_HOME}])

# ===========================================================================
# Compiler stuff
# ===========================================================================

CC=`${R_HOME}/bin/R CMD config CC`
CPPFLAGS=""
CFLAGS=`R CMD config CFLAGS`
LDFLAGS=""
WARNFLAGS="-Wall -Wmissing-prototypes"

# ===========================================================================
# yacc and lex stuff
# ===========================================================================

AC_PROG_LEX
AC_PROG_YACC

AC_SUBST([LEX])
AC_SUBST([YACC])

# ===========================================================================
# postgis version stuff
# ===========================================================================

POSTGIS_MAJOR_VERSION=`cat Version.config | grep ^POSTGIS_MAJOR_VERSION | sed 's/[[^=]]*=\([[0-9]]\)/\1/g'`
POSTGIS_MINOR_VERSION=`cat Version.config | grep ^POSTGIS_MINOR_VERSION | sed 's/[[^=]]*=\([[0-9]]\)/\1/g'`
POSTGIS_PATCH_VERSION=`cat Version.config | grep ^POSTGIS_MICRO_VERSION | sed 's/[[^=]]*=\([[0-9]]\)/\1/g'`
POSTGIS_LIB_VERSION=${POSTGIS_MAJOR_VERSION}.${POSTGIS_MINOR_VERSION}.${POSTGIS_PATCH_VERSION}

# ===========================================================================
# SRID stuff
# ===========================================================================

SRID_MAX=999999
SRID_USR_MAX=998999

AC_SUBST([SRID_MAX])
AC_SUBST([SRID_USR_MAX])

# ===========================================================================
# GEOS stuff
# ===========================================================================


### FIXME
GEOS_CONFIG="geos-config"

GEOS_FULL_VERSION=`${GEOS_CONFIG} --version`
GEOS_MAJOR_VERSION=`${GEOS_CONFIG} --version | cut -d. -f1 | sed 's/[[^0-9]]//g'`
GEOS_MINOR_VERSION=`${GEOS_CONFIG} --version | cut -d. -f2 | sed 's/[[^0-9]]//g'`
GEOS_PATCH_VERSION=`${GEOS_CONFIG} --version | cut -d. -f3 | sed 's/[[^0-9]]//g'`
if test x"${GEOS_PATCH_VERSION}" = x""; then
  GEOS_PATCH_VERSION="0";
fi
POSTGIS_GEOS_VERSION="${GEOS_MAJOR_VERSION}${GEOS_MINOR_VERSION}"

CPPFLAGS="${CPPFLAGS} `${GEOS_CONFIG} --cflags`"
LDFLAGS="${LDFLAGS} `${GEOS_CONFIG} --clibs`"

AC_SUBST([POSTGIS_LIB_VERSION])
AC_SUBST([POSTGIS_MAJOR_VERSION])
AC_SUBST([POSTGIS_MINOR_VERSION])

AC_SUBST([POSTGIS_GEOS_VERSION])

# ===========================================================================
# SFCGAL stuff
# ===========================================================================

### Fix me

# ===========================================================================
# Config stuff
# ===========================================================================

#AC_MSG_NOTICE([CC: ${CC}])
#AC_MSG_NOTICE([CPPFLAGS: ${CPPFLAGS}])
#AC_MSG_NOTICE([CFLAGS: ${CFLAGS}])
#AC_MSG_NOTICE([LDFLAGS: ${LDFLAGS}])
#AC_MSG_NOTICE([WARNFLAGS: ${WARNFLAGS}])

AC_SUBST([CC])
AC_SUBST([CPPFLAGS])
AC_SUBST([CFLAGS])
AC_SUBST([LDFLAGS])
AC_SUBST([WARNFLAGS])


AC_CONFIG_FILES([Makefile liblwgeom.h])
AC_OUTPUT
