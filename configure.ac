AC_PREREQ(2.61)

AC_INIT([liblwgeom], [0.1.0])

R_HOME="`R RHOME`"
if test -z "${R_HOME}"; then
  AC_MSG_ERROR([Could not determine R_HOME.])
fi

CC=`${R_HOME}/bin/R CMD config CC`


sysname="$(${R_HOME}/bin/Rscript -e "cat(Sys.info()[['sysname']])")"

if test x"${sysname}" = x"Linux"; then
  platform="linux"
elif test x"${sysname}" = x"Darwin"; then
  platform="mac"
else
  platform="unknown"
fi

AC_MSG_NOTICE([System name: ${sysname}])
AC_MSG_NOTICE([Platform: ${platform}])

AC_ARG_ENABLE(
  [verbose],
  AC_HELP_STRING(
    [--enable-verbose],
    [Enable verbose output of build]
  ),
  [VERBOSE="yes"],
  [VERBOSE="no"]
)

# ===========================================================================
# PROJ stuff
# ===========================================================================

### Fixme

PROJ_LIBS="-lproj"
PROJ_CPPFLAGS=""

# ===========================================================================
# GEOS stuff
# ===========================================================================

### FIXME - use libgeos
AC_PATH_PROG(GEOS_CONFIG, geos-config, no)

if test x"${GEOS_CONFIG}" = x"no"; then
  AC_MSG_ERROR([Unable to find geos-config.])   
fi

GEOS_LIBS="`${GEOS_CONFIG} --ldflags` -lgeos_c"
GEOS_CPPFLAGS="`${GEOS_CONFIG} --cflags`"
  
# ===========================================================================
# liblwgeom stuff
# ===========================================================================

LWGEOM_DIR=liblwgeom/

if ! test -d ${LWGEOM_DIR}; then
  AC_MSG_ERROR([liblwgeom source directory could not be found.])   
fi
  

INST_DIR=`pwd`/inst

cd ${LWGEOM_DIR}

AC_MSG_NOTICE([Configuring liblwgeom])
if test x"${VERBOSE}" = x"no"; then
  sh ./configure > /dev/null 2>&1
else
  sh ./configure
fi
    
AC_MSG_NOTICE([Compiling liblwgeom])
if test x"${VERBOSE}" = x"no"; then
  make install > /dev/null 2>&1
else
  make install
fi

cd ..

if ! test -e "inst/lib/liblwgeom.a"; then
  AC_MSG_ERROR([Building static liblwgeom failed.])   
fi
  
strip -x -S inst/lib/liblwgeom.a > /dev/null 2>&1

LWGEOM_LIBS="-L${INST_DIR}/lib/ -llwgeom"
LWGEOM_LIBS="${INST_DIR}/lib/liblwgeom.a"
LWGEOM_CPPFLAGS="-I${INST_DIR}/include"
  
#if test x"${platform}" = x"mac"; then
#  LWGEOM_LIBS="${LWGEOM_LIBS} -lc++"
#fi

# ===========================================================================
# testing stuff
# ===========================================================================

PKG_CPPFLAGS="${GEOS_CPPFLAGS} ${PROJ_CPPFLAGS} ${LWGEOM_CPPFLAGS}"
PKG_LIBS="${GEOS_LIBS} ${PROJ_LIBS} ${LWGEOM_LIBS}"

CPPFLAGS=${PKG_CPPFLAGS}
LIBS=${PKG_LIBS}

AC_LANG_PUSH([C])

AC_CHECK_HEADERS(
  [liblwgeom.h liblwgeom_topo.h],
  [],
  [AC_MSG_ERROR([Unable to locate liblwgeom headers.])]
) 

AC_CHECK_LIB(
  [lwgeom], 
  [lwgeom_version], 
  [], 
  [AC_MSG_ERROR([Unable to locate liblwgeom])]
)

AC_SUBST([PKG_CPPFLAGS])
AC_SUBST([PKG_LIBS])

AC_CONFIG_FILES([src/Makevars])
AC_OUTPUT
