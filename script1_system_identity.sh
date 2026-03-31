#!/bin/bash
# =============================================================================
# Script 1: System Identity Report
# Author: JIYA KHURANA
# Course: Open Source Software — OSS NGMC Capstone Project
# Description: Displays a formatted welcome screen with key system information
#              including distro, kernel, user details, uptime, and OSS license.
# =============================================================================

# --- Variables ---
STUDENT_NAME="JIYA KHURANA"
SOFTWARE_CHOICE="Python"

# Gather system info using command substitution
KERNEL=$(uname -r)                          # Current kernel version
DISTRO=$(cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"')  # Distro name
USER_NAME=$(whoami)                         # Currently logged-in user
HOME_DIR=$HOME                              # Home directory of the user
UPTIME=$(uptime -p)                         # Human-readable uptime
CURRENT_DATE=$(date '+%A, %d %B %Y')        # Full formatted date
CURRENT_TIME=$(date '+%H:%M:%S %Z')         # Current time with timezone
HOSTNAME=$(hostname)                        # Machine hostname
ARCH=$(uname -m)                            # CPU architecture

# Identify the OS license
# Most Linux systems use GPL — we detect common distros
OS_ID=$(cat /etc/os-release 2>/dev/null | grep "^ID=" | cut -d= -f2 | tr -d '"')
case $OS_ID in
    ubuntu|debian)      OS_LICENSE="GNU GPL (Debian/Ubuntu is GPL-licensed at its core)" ;;
    fedora|rhel|centos) OS_LICENSE="GNU GPL v2 / v3 (Red Hat family)" ;;
    arch)               OS_LICENSE="GNU GPL (Arch Linux)" ;;
    *)                  OS_LICENSE="GNU General Public License (GPL) — Linux Kernel is GPL v2" ;;
esac

# --- Display the report ---
echo "============================================================"
echo "         OPEN SOURCE AUDIT — SYSTEM IDENTITY REPORT        "
echo "============================================================"
echo ""
echo "  Student     : $STUDENT_NAME"
echo "  Software    : $SOFTWARE_CHOICE (Audited Project)"
echo ""
echo "------------------------------------------------------------"
echo "  SYSTEM INFORMATION"
echo "------------------------------------------------------------"
echo "  Hostname    : $HOSTNAME"
echo "  Distro      : $DISTRO"
echo "  Kernel      : $KERNEL"
echo "  Architecture: $ARCH"
echo ""
echo "------------------------------------------------------------"
echo "  USER INFORMATION"
echo "------------------------------------------------------------"
echo "  Logged in as: $USER_NAME"
echo "  Home Dir    : $HOME_DIR"
echo ""
echo "------------------------------------------------------------"
echo "  DATE & TIME"
echo "------------------------------------------------------------"
echo "  Date        : $CURRENT_DATE"
echo "  Time        : $CURRENT_TIME"
echo "  Uptime      : $UPTIME"
echo ""
echo "------------------------------------------------------------"
echo "  LICENSE INFORMATION"
echo "------------------------------------------------------------"
echo "  OS License  : $OS_LICENSE"
echo "  Python Lic. : Python Software Foundation License (PSF)"
echo "  PSF Note    : PSF License is OSI-approved, permissive,"
echo "                allows use in proprietary software."
echo ""
echo "============================================================"
echo "  'Free software is a matter of liberty, not price.'"
echo "                                        — Richard Stallman"
echo "============================================================"
