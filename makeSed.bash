#!/bin/bash

########################################################################
#                                                                      #
# Copyright(C) 2018 - LBS - (Single person developer.)                 #
# Fri Mar  9 15:45:22 CET 2018                                         #
# Autor: Leonid Burmistrov                                             #
#                                                                      #
# File description:                                                    #
#                 This script configure the LBS framework to work      #
#                 with root files.                                     #
#                                                                      #
# Input paramete:                                                      #
#                                                                      #
# This software is provided "as is" without any warranty.              #
#                                                                      #
########################################################################

makeSed_bash () {
    anaName=$1
    baseClassSuffix="base"
    anaBaseName=$anaName$baseClassSuffix
    runanaName='run'$anaName
    runanaCppName=$runanaName'.cpp'
    runanaBashName=$runanaName'.bash'
    makeFileName="Makefile$anaName"
    #########
    #TCana.cpp  TCana.hh  TCbase.cpp  TCbase.hh Makefile runAna.cpp
    sed -e "s/TCana/$anaName/g" src/TCana.cpp > src/$anaName.cpp
    sed -e "s/TCana/$anaName/g" src/TCana.hh > src/tmp.hh
    sed -e "s/TCbase/$anaBaseName/g" src/tmp.hh > src/$anaName.hh
    sed -e "s/TCbase/$anaBaseName/g" src/TCbase.cpp > src/$anaBaseName.cpp
    sed -e "s/TCbase/$anaBaseName/g" src/TCbase.hh > src/$anaBaseName.hh
    #########
    cp runTCana.cpp runTCanat.cpp
    sed -e "s/TCana/$anaName/g" runTCanat.cpp > runTCana.cpp
    #########
    mv runTCana.cpp $runanaCppName 
    #########
    cp runTCana.bash runTCanat.bash
    sed -e "s/runTCana/$runanaName/g" runTCanat.bash > runTCana.bash
    cp runTCana.bash runTCanat.bash
    sed -e "s/Makefile/$makeFileName/g" runTCanat.bash > $runanaBashName
    chmod u+x $runanaBashName
    #########
    cp Makefile Makefilet
    sed -e "s/TCana/$anaName/g" Makefilet > Makefile
    cp Makefile Makefilet
    sed -e "s/TCbase/$anaBaseName/g" Makefilet > Makefile
    cp Makefile Makefilet
    sed -e "s/runTCana/$runanaName/g" Makefilet > Makefile
    mv Makefile $makeFileName
    #########
    make -f $makeFileName clean;
    #########
    rm src/TCana.cpp  src/TCana.hh  src/TCbase.cpp  src/TCbase.hh Makefilet src/tmp.hh runTCanat.cpp makeSed.bash
    rm runTCanat.bash runTCana.bash
    rm -rf .svn obj/.svn src/.svn
}

# Check number of parameters 
if [ $# -ne 1 ]; 
then 
    echo " ---> EROOR illegal number of parameters"
    echo " ---> [1] name of the analysis class"
    echo " ---> For example : ana"
    #exit
else 
    makeSed_bash $1
fi
