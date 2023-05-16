#!/bin/bash

# colors
GREEN="\033[0;32m"
WHITE="\033[1;37m"
COLOR_END="\033[0m"
CYAN="\033[0;36m"
CYAN_FAIR="\033[1;36m"
BLUE="\033[0;34m"
YELLOW="\033[1;33m"

PISCA="\033[5;32m" # \033[5;COR

function getGCCVersion(){
        url="https://mirror.cedia.org.ec/gnu/gcc/gcc-$1/gcc-$1.tar.gz"
}

echo -e "${GREEN}[>]${COLOR_END} ${YELLOW}Copyright (C) 2023 VersatusHPC, Inc.${COLOR_END}"
echo -e "${GREEN}[>]${COLOR_END} ${WHITE}$(date "+%d %B %Y, %A - %H:%M:%S")${COLOR_END}\n"

OK=1
url="https://mirror.cedia.org.ec/gnu/gcc/gcc-9.4.0/gcc-9.4.0.tar.gz"

if [ $OK -eq 0 ]; then
        echo -e "${GREEN}[>]${COLOR_END} ${WHITE}Please, before running this script set the configuration command below and set OK variable to 1...${COLOR_END}\n"
else
        echo -e "${GREEN}[>]${COLOR_END} ${WHITE}Enter the version you want to install: ${COLOR_END}"
        read version
        echo -e "${GREEN}[>]${COLOR_END} ${WHITE}Enter the path location you want to install: ${COLOR_END}"
        read pathinstall


        echo -e "${GREEN}[+]${COLOR_END} ${WHITE}Installing GCC $version${COLOR_END}"
        getGCCVersion $version
        echo -e "${GREEN}[+]${COLOR_END} ${WHITE}Downloading from $url${COLOR_END}"
        wget $url

        echo -e "${GREEN}[+]${COLOR_END} ${WHITE}Untaring file...${COLOR_END}"
        tar -xzf gcc-$version.tar.gz

        echo -e "${GREEN}[+]${COLOR_END} ${WHITE}Change directory name...${COLOR_END}"
        mv gcc-$version $version

        echo -e "${GREEN}[+]${COLOR_END} ${WHITE}Entering directory $version...${COLOR_END}"
        cd $version

        echo -e "${GREEN}[+]${COLOR_END} ${WHITE}Configuring...${COLOR_END}"
        echo -e "${GREEN}[+]${COLOR_END} ${WHITE}./configure -v --prefix=$pathinstall --enable-checking=release --enable-languages=c,c++,fortran --enable-bootstrap${COLOR_END}\n"

        ./configure -v --prefix=$pathinstall --enable-checking=release --enable-languages=c,c++,fortran --enable-bootstrap --with-gmp=/usr --with-gmp-lib=/usr/lib --with-gmp-include=/usr/include --with-mpfr=/usr --with-mpfr-lib=/usr/lib --with-mpfr-include=/usr/include --with-mpc=/usr --with-mpc-lib=/usr/lib --with-mpc-include=/usr/include --disable-multilib

        echo -e "${GREEN}[+]${COLOR_END} ${WHITE}Running make command...${COLOR_END}"
        make

        echo -e "${GREEN}[+]${COLOR_END} ${WHITE}Running make install-strip command...${COLOR_END}"
        make install-strip

fi

echo -e "${GREEN}[+]${COLOR_END} ${WHITE}Bye bye!${COLOR_END}"
