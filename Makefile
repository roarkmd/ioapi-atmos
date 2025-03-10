#.........................................................................
# VERSION "$Id: Makefile.template 1 2017-06-10 18:05:20Z coats $"
#      EDSS/Models-3 I/O API Version 3.2.
#.........................................................................
# COPYRIGHT
#       (C) 1992-2002 MCNC and Carlie J. Coats, Jr., and
#       (C) 2003-2004 by Baron Advanced Meteorological Systems,
#       (C) 2005-2014 Carlie J. Coats, Jr., and
#       (C) 2014-     UNC Institute for the Environment
#       Distributed under the GNU Lesser PUBLIC LICENSE version 2.1
#       See file "LGPL.txt" for conditions of use.
#.........................................................................
#  Usage:
#       Either edit this Makefile to un-comment the options you want, or
#       override the options by environment or command-line variables.
#       For example:
#
#    setenv BIN      Linux2_x86_64ifort
#    setenv BASEDIR  /wherever/I-ve/un-tarred/the/code
#    setenv CPLMODE  nocpl
#    make
#
#  or:
#
#    make BIN=Linux2_x86_64pg  CPLMODE=pncf INSTALL=/foo/bar
#    
#.........................................................................
#  Environment/Command-line Variables:
#
#       BIN     machine/OS/compiler/mode type. Shows up as suffix
#               for "$(IODIR)/Makeinclude.$(BIN)" to determine compilation
#               flags, and in $(OBJDIR) and $(INSTALL) to determine
#               binary directories
#
#       INSTALL installation-directory root, used for "make install":
#               "libioapi.a" and the tool executables will be installed
#               in $(INSTALL)/$(BIN)
#
#       LIBINST overrides  $(INSTALL)/$(BIN) for libioapi.a
#
#       BININST overrides  $(INSTALL)/$(BIN) for M3TOOLS executables
#.........................................................................
#  Directories:
#
#       $(BASEDIR)  is the root directory for the I/O API library source,
#                   the M3Tools and M3Test source,the  HTML documentation,
#                   and the (machine/compiler/flag-specific) binary
#                   object/library/executable directories.
#       $(HTMLDIR)  is the web documentation
#       $(IODIR)    is the I/O API library source
#       $(TOOLDIR)  is the "M3TOOLS" source
#       $(OBJDIR)   is the current machine/compiler/flag-specific
#                   build-directory
#       $(INSTALL)  installation-directory root, used for "make install":
#                   "libioapi.a" and the tool executables will be installed
#                   in $(INSTALL)/$(BIN) object/library/executable directory
#.........................................................................
# Note On Library Versions and configuration:
#
#       Environment variable "BIN" specifies library version up to
#       link- and compile-flag compatibility.  Dependecies upon machine,
#       OS, and compiler are found in file "Makeinclude.$(BIN)".
#       Command-line "make BIN=<something>..." overrides environment
#       variable "% setenv BIN <something>" which overrides the
#       make-variable default below.
#
#       IN PARTICULAR, pay attention to the notes for various versions
#       that may be built for Linux x86 with the Portland Group
#       compilers:  see comments in $(IODIR)/include 'MAKEINCLUDE'.Linux2_x86pg
#.........................................................................
# Special Make-targets
#
#       configure:  "Makefile"s, with the definitions indicated below.
#       all:      OBJDIR, FIXDIR, libioapi.a, and executables, with
#                 the current mode.
#       lib:      OBJDIR, FIXDIR, libioapi.a
#       clean:    remove .o's, libioapi.a, and executables from OBJDIR
#       rmexe:    remove executables from OBJDIR
#       relink:   rebuild executables from OBJDIR
#       install:  copy "libioapi.a" and executables to $(INSTDIR)
#       dirs:     make OBJDIR and FIXDIR directories
#       fix:      FIXDIR and extended-fixed-source INCLUDE-files
#       gtar:     GZipped tar-file of the source and docs
#       nametest: test of name-mangling compatibility (requires that
#                 libnetcdff.a be manually placed into $(OBJDIR))
#
######################################################################
#      ----------   Definitions for "make configure"  ------------------
#
#  VERSIONING DEFINITIONS:  the preprocessor definitions in $(IOAPIDEFS)
#  (below) govern I/O API behavior; versions with distinct combinations
#  of these options are NOT library- nor object-compatible and should
#  be built in *distinct*  $(OBJDIR)s:
#
#       Defining IOAPICPL turns on PVM-enabled "coupling mode" and
#       requires "libpvm3.a" for linking.
#
#       Defining IOAPI_PNCF turns on PnetCDF based distributed I/O
#       and requires libpnetcdf.a and libmpi.a for linking; it should
#       be used only with an MPI-based ${BIN} (e.g., Linux2_x86_64ifortmpi)
#
#       Defining IOAPI_NCF4 turns on full netCDF-4 interfaces, including
#       support for INTEGER*8 variables and attributes.  It requires
#       extra libraries for linking, which can be found by running the
#       commands  "nf-config --flibs" and "nc-config --libs"
#
#       Defining IOAPI_NO_STDOUT suppresses WRITEs to the screen in
#       routines INIT3(), M3MSG2(), M3MESG(), M3PARAG(), and M3ABORT().
#       This also helps control the "double-printed-message" behavior
#       caused by recent SGI compilers.
#
#       Defining IO_360 creates the 360-day "global climate" version
#       of the library.
#
#       Defining BIN3_DEBUG turns on trace-messages for native-binary
#       mode routines.
######################################################################
#      ----------   Default/fall-back Definitions --------------------
#      For POSIX "make", environment variables override these; 
#      variable setting on the command line ("make VAR=VALUE ...")
#      overrides that.
#
#      GNU "make" DOES NOT FOLLOW POSIX, AND INSTEAD DOES ITS OWN
#       WRONG-HEADED THING, MAKING IT IMPOSSIBLE TO HAVE DEFAULTS
#       THAT ARE THEN OVER-RIDDEN BY THE ENVIRONMENT !!
#
#  BIN        : Use 64-bit gcc/gfortran
#  BASEDIR    : source under this current directory
#  INSTALL    : installation directly under ${HOME}
#  LIBINST    :  for installation of library
#  BININST    : for installation of m3tools executables
#  CPLMODE    : nocpl
#  IOAPIDEFS  : none (can override for climo-year, etc.
#  PVMINCL    : none
#  NCFLIBS    : assumes netCDF-4-style separate libs
# 
# 
# BIN        = Linux2_x86_64
# BASEDIR    = ${PWD}
# INSTALL    = ${HOME}
# LIBINST    = $(INSTALL)/$(BIN)
# BININST    = $(INSTALL)/$(BIN)
# CPLMODE    = nocpl
# IOAPIDEFS  = 
# PVMINCL    =
# NCFLIBS    = -lnetcdff -lnetcdf
# 
#               ****   Variants   ****
#
# BASEDIR    = ${HOME}/ioapi-3.2    # fall-back to versioned source under this directory
#
# CPLMODE   = cpl                   #  turn on PVM coupling mode
# PVMINCL   = $(PVM_ROOT)/conf/$(PVM_ARCH).def
# IOAPIDEFS = "-DIOAPICPL"
#
# CPLMODE   = pncf                  #  turn on PnetCDF distributed-file mode
# NCFLIBS   = -lpnetcdf -lnetcdff -lnetcdf
# IOAPIDEFS = "-DIOAPI_PNCF"
# 
# NCFLIBS   = -lnetcdf             #  Assumes netcdf-3-style unified libs
# IOAPIDEFS = "-DIOAPI_PNCF"
# 
# NCFLIBS   = -lnetcdff -lnetcdf -lhdf5_hl -lhdf5 -lz  # netcdf-4 with HDF but not DAP
# IOAPIDEFS = "-DIOAPI_NCF4"
# 
# NCFLIBS   = -lpnetcdf -lnetcdff -lnetcdf -lhdf5_hl -lhdf5 -lz  # PnetCDF+netcdf-4 with HDF but not DAP
# IOAPIDEFS = "-DIOAPI_PNCF -DIOAPI_NCF4"
# 
# NCFLIBS   = "-lnetcdff -lnetcdf -lhdf5hl_fortran -lhdf5_fortran -lhdf5_hl -lhdf5 -lmfhdf -ldf -ljpeg -lm -lz -lcurl -lsz"   # all-out netcdf-4
# 
# NCFLIBS   = "`nf-config --flibs` `nc-config --libs`"   # general-case netcdf-4 with NetCDF "bin" in ${path}
# 
# INSTALL   = <installation base-directory> -- what GNU "configure" calls "--prefix=..."
# LIBINST   = $(INSTALL)/lib
# BININST   = $(INSTALL)/bin

#      ----------  Edit-command used by "make configure"  to customize the "*/Makefile*"

SEDCMD = \
-e 's|IOAPI_BASE|$(BASEDIR)|' \
-e 's|LIBINSTALL|$(LIBINST)|' \
-e 's|BININSTALL|$(BININST)|' \
-e 's|IOAPI_DEFS|$(IOAPIDEFS)|' \
-e 's|NCFLIBS|$(NCFLIBS)|' \
-e 's|MAKEINCLUDE|include $(IODIR)/Makeinclude|' \
-e 's|PVMINCLUDE|include  $(PVMINCL)|'


#      ----------   I/O API Build System directory definitions  --------

VERSION    = 3.2-${CPLMODE}
#BASEDIR    = ${PWD}
#NCFLIBS    = -lnetcdff -lnetcdf
IODIR      = $(BASEDIR)/ioapi
FIXDIR     = $(IODIR)/fixed_src
HTMLDIR    = $(BASEDIR)/HTML
TOOLDIR    = $(BASEDIR)/m3tools
OBJDIR     = $(BASEDIR)/$(BIN)


#      ----------------------   TOP-LEVEL TARGETS:   ------------------
#
all:  dirs fix configure
	(cd $(IODIR)   ; make BIN=${BIN} all)
	(cd $(TOOLDIR) ; make BIN=${BIN} all)

test:
	(cd $(BASEDIR)/tests; ioapitest.csh ${BASEDIR} ${BIN} )

configure: #${IODIR}/Makefile ${TOOLDIR}/Makefile
	(cd $(IODIR)   ;  sed $(SEDCMD) < Makefile.$(CPLMODE).sed > Makefile )
	(cd $(TOOLDIR) ;  sed $(SEDCMD) < Makefile.$(CPLMODE).sed > Makefile )

bins:  dirs
	(cd $(IODIR)   ; make bins)
	(cd $(TOOLDIR) ; make bins)

clean:
	(cd $(IODIR)   ; make BIN=${BIN} -i clean)
	(cd $(TOOLDIR) ; make BIN=${BIN} -i clean)

binclean:  dirs
	(cd $(IODIR)   ; make binclean)
	(cd $(TOOLDIR) ; make binclean)

relink:
	(cd $(TOOLDIR) ; make BIN=${BIN} relink)

binrelink:
	(cd $(TOOLDIR) ; make binrelink)

install: $(LIBINST) $(BININST)
	echo "Installing I/O API and M3TOOLS in $(LIBINST) and $(BININST)"
	(cd $(IODIR)   ; make BIN=${BIN} INSTDIR=${LIBINST} install)
	(cd $(TOOLDIR) ; make BIN=${BIN} INSTDIR=${BININST} install)

dirs: $(OBJDIR) $(FIXDIR)

fix:
	(cd $(IODIR)   ; make fixed_src)

gtar:
	cd $(BASEDIR); date > VERSION.txt; \
gtar cvfz ioapi-$(VERSION).tar.gz --dereference -X exclude \
Makefile*  *.txt exclude ioapi HTML m3tools tests

lib:  dirs
	(cd $(IODIR)   ; make all)

nametest:  lib $(OBJDIR)/libnetcdff.a
	(cd $(IODIR)   ; make nametest)

$(FIXDIR):
	mkdir -p $(FIXDIR)

$(OBJDIR):
	mkdir -p $(OBJDIR)

$(LIBINST): $(INSTALL)
	cd $(INSTALL); mkdir -p $(LIBINST)

$(BININST): $(INSTALL)
	cd $(INSTALL); mkdir -p $(BININST)

