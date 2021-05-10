#!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2018 - LBS - (Single person developer.)                 #
# Tue Mar  6 20:15:29 JST 2018                                         #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# File description:                                                    #
#                 This script run the analysis class.                  #
#                                                                      #
# Input paramete:                                                      #
#                                                                      #
# This software is provided "as is" without any warranty.              #
#                                                                      #
########################################################################

#source /home/gred/root_34_36/bin/thisroot.sh;
#useroot53434
#useroot60806

#Analyse list of root files 
rootFilesList="./rootFileList.dat"
outHistF="./hist.root"

#Or analyse single root file 
inRootFiles="./180929-154859.CSV.root"
outHistSingleF="./histSingle.root"

make -f Makefile clean; make -f Makefile runTCana;

function printHelp {
    echo " --> ERROR in input arguments "
    echo " [0] -d  : single root file"
    echo " [0] -l  : list of root files"
    echo " [0] -h  : print help"
}

if [ $# -eq 0 ] 
then    
    printHelp
else
    if [ "$1" = "-d" ]; then
	./runTCana 1 $inRootFiles $outHistSingleF
    elif [ "$1" = "-l" ]; then
	./runTCana 0 $rootFilesList $outHistF
        printHelp
    elif [ "$1" = "-h" ]; then
        printHelp
    else
        printHelp
    fi
fi

#espeak "I have done"
