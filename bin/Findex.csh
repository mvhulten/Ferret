#! /bin/csh -f
#! *sh* 10/91
#! Findex
#! browse the Index of the Ferret Users Guide

# enter the Index at the top
if ($#argv == "0") then
   echo "Note: Index page numbers refer to the hard copy FERRET User's Guide"
   echo "      The on-line FERRET User's Guide is not page numbered"
   echo -n "Hit <CR> to continue ..."
   echo " " 
   set pause = $<
   more -d $FER_DIR/doc/ferret_ug_index.txt
   exit
endif

# too many arguments: explain the syntax
if ($#argv >= 2) then
     echo " "
     echo "*** Syntax error in command entered ***"
     echo " "
     echo "     Usage:  Findex    or    Findex  string"
     echo " "
     echo "     Note: multi-word strings need to be enclosed in quotations"
     echo " "
     exit
endif

# use grep for case-insensitive search
   echo "*** Index page numbers refer to the hard copy or PDF FERRET User's Guide ***"
   echo "*** The on-line document is not page numbered                     ***"
   echo "*********************************************************************"
   echo " "
   grep -i "$argv[1]" $FER_DIR/doc/ferret_ug_index.txt
