#!/bin/bash
# =============================================================================
# Script 2: FOSS Package Inspector
# Author: JIYA KHURANA
# Course: Open Source Software — OSS NGMC Capstone Project
# Description: Checks if a given open-source package is installed, shows its
#              version/license info, and prints a philosophy note about it.
# Usage: ./script2_package_inspector.sh [package_name]
#        If no argument is given, defaults to 'python3'
# =============================================================================

# Use command-line argument if provided, else default to python3
PACKAGE=${1:-python3}

echo "============================================================"
echo "         FOSS PACKAGE INSPECTOR                            "
echo "============================================================"
echo "  Inspecting package: $PACKAGE"
echo "------------------------------------------------------------"

# --- Detect package manager and check installation ---
# We support both rpm-based (Fedora/RHEL) and dpkg-based (Debian/Ubuntu) systems

if command -v rpm &>/dev/null; then
    # RPM-based system (Fedora, CentOS, RHEL)
    PKG_MANAGER="rpm"
    if rpm -q "$PACKAGE" &>/dev/null; then
        INSTALLED=true
        VERSION=$(rpm -qi "$PACKAGE" | grep "^Version" | awk '{print $3}')
        LICENSE=$(rpm -qi "$PACKAGE" | grep "^License" | awk '{$1=$2=""; print $0}' | xargs)
        SUMMARY=$(rpm -qi "$PACKAGE" | grep "^Summary" | awk '{$1=$2=""; print $0}' | xargs)
    else
        INSTALLED=false
    fi

elif command -v dpkg &>/dev/null; then
    # Debian/Ubuntu-based system
    PKG_MANAGER="dpkg"
    if dpkg -l "$PACKAGE" 2>/dev/null | grep -q "^ii"; then
        INSTALLED=true
        VERSION=$(dpkg -l "$PACKAGE" 2>/dev/null | grep "^ii" | awk '{print $3}')
        # dpkg doesn't store license; get from package info
        LICENSE=$(apt-cache show "$PACKAGE" 2>/dev/null | grep -i "^License\|^Section" | head -1 | awk '{$1=""; print $0}' | xargs)
        SUMMARY=$(apt-cache show "$PACKAGE" 2>/dev/null | grep "^Description:" | head -1 | sed 's/^Description: //')
    else
        INSTALLED=false
    fi

else
    # Fallback: try 'which' to check if binary is available
    PKG_MANAGER="which"
    if which "$PACKAGE" &>/dev/null; then
        INSTALLED=true
        VERSION=$("$PACKAGE" --version 2>&1 | head -1)
        LICENSE="Check official documentation"
        SUMMARY="$PACKAGE found in PATH"
    else
        INSTALLED=false
    fi
fi

# --- Report installation status with if-then-else ---
if [ "$INSTALLED" = true ]; then
    echo "  Status      : [INSTALLED]"
    echo "  Version     : ${VERSION:-N/A}"
    echo "  License     : ${LICENSE:-N/A}"
    echo "  Summary     : ${SUMMARY:-N/A}"
    echo "  Pkg Manager : $PKG_MANAGER"
else
    echo "  Status      : [NOT INSTALLED]"
    echo ""
    echo "  To install, try one of:"
    echo "    sudo apt install $PACKAGE     (Debian/Ubuntu)"
    echo "    sudo dnf install $PACKAGE     (Fedora/RHEL)"
fi

echo ""
echo "------------------------------------------------------------"
echo "  OPEN SOURCE PHILOSOPHY NOTE"
echo "------------------------------------------------------------"

# --- Case statement: print a philosophy note per known package ---
case $PACKAGE in
    python3|python)
        echo "  Python: Born from Guido van Rossum's desire for a language"
        echo "  that was readable, powerful, and free. The PSF License ensures"
        echo "  Python remains open for everyone — students, researchers, and"
        echo "  companies alike. 'Batteries included' philosophy = open sharing."
        ;;
    httpd|apache2)
        echo "  Apache HTTP Server: Forged from patches to NCSA HTTPd in 1995."
        echo "  Its name — 'a patchy server' — reflects the open-source spirit:"
        echo "  many contributors improving one shared tool. Powers ~30% of the web."
        ;;
    mysql|mysql-server)
        echo "  MySQL: A dual-license story — GPL for open-source users, commercial"
        echo "  for those who won't share changes. Shows how OSS can sustain itself"
        echo "  economically while keeping freedom at its core."
        ;;
    firefox)
        echo "  Firefox: Mozilla's answer to browser monopoly. A nonprofit fighting"
        echo "  for an open web — proof that mission-driven OSS can compete with"
        echo "  billion-dollar corporations. MPL 2.0 keeps the code accessible."
        ;;
    vlc)
        echo "  VLC: Built by students at École Centrale Paris who just wanted to"
        echo "  stream video over their campus network. No commercial motive — pure"
        echo "  problem-solving, shared freely with the world."
        ;;
    git)
        echo "  Git: Linus Torvalds built Git in 2005 in two weeks — after BitKeeper"
        echo "  revoked its free license for the Linux project. A tool born from the"
        echo "  frustration of proprietary control. GPL v2 — forever free."
        ;;
    libreoffice)
        echo "  LibreOffice: Born from a community fork of OpenOffice when Oracle"
        echo "  acquired Sun. A real-world lesson: communities can reclaim their tools."
        echo "  MPL 2.0 ensures no single company can hold it hostage again."
        ;;
    linux|linux-kernel)
        echo "  Linux Kernel: The most collaborative software project in history."
        echo "  GPL v2 ensures no one can close the source. Every smartphone, server,"
        echo "  and supercomputer runs on code built by thousands of volunteers."
        ;;
    *)
        # Default message for any unrecognised package
        echo "  '$PACKAGE' is part of the vast open-source ecosystem."
        echo "  Open-source software means anyone can study, modify, and share"
        echo "  the code. This transparency builds trust and accelerates innovation."
        ;;
esac

echo ""
echo "============================================================"
