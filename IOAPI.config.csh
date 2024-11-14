#!/bin/csh

unsetenv BIN
setenv BIN Linux2_x86_64ifx

#Add MASTERDIR, perhaps the location this file is in?
setenv MASTERDIR YOUR_MASTERDIR
setenv IOAPI_HOME ${MASTERDIR}/ioapi-atmos
setenv IOAPI_BASE $IOAPI_HOME
setenv IOAPILIBS  ${IOAPI_HOME}/${BIN}
setenv IOAPIINCD  ${IOAPI_HOME}/${BIN}
setenv IOBIN      ${IOAPI_HOME}/${BIN}

setenv BASEDIR    ${PWD}
setenv INSTALL    ${PWD}
setenv LIBINST    ${INSTALL}/${BIN}
setenv BININST    ${INSTALL}/${BIN}
setenv CPLMODE    nocpl
setenv IOAPIDEFS  "-DIOAPI_NCF4" 
setenv PVMINCL 
setenv VERSION    '3.2-${CPLMODE}'


setenv NETCDFC ${IOAPI_HOME}/dependencies/netcdfc.4.9.2_intel
setenv NETCDFF ${IOAPI_HOME}/dependencies/netcdff.4.6.1_intel
#libm etc are dynamic system libraries
#setenv NCFLIBS "-L${NETCDFF}/lib -lnetcdff -L${NETCDFC}/lib -lnetcdf -lm -lz -lsz"
setenv NCFLIBS "-L${NETCDFF}/lib -lnetcdff -L${NETCDFC}/lib -lnetcdf"
