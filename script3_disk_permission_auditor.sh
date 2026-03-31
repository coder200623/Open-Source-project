#!/bin/bash
# =============================================================================
# Script 3: Disk and Permission Auditor
# Author: JIYA KHURANA
# Course: Open Source Software — OSS NGMC Capstone Project
# Description: Loops through key Linux directories and reports their disk usage,
#              owner, group, and permission string. Also checks Python-specific
#              directories to link the audit to our chosen OSS project.
# =============================================================================

# --- List of important system directories to audit ---
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/usr/lib" "/opt" "/root")

echo "============================================================"
echo "         DISK AND PERMISSION AUDITOR                       "
echo "============================================================"
printf "%-20s %-12s %-30s\n" "Directory" "Size" "Permissions (perm user group)"
echo "------------------------------------------------------------"

# --- For loop: iterate over each directory ---
for DIR in "${DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        # Extract permissions, owner, and group using ls -ld and awk
        PERMS=$(ls -ld "$DIR" | awk '{print $1, $3, $4}')
        # Get disk usage; suppress permission-denied errors with 2>/dev/null
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)
        # Print aligned output
        printf "%-20s %-12s %-30s\n" "$DIR" "${SIZE:-N/A}" "$PERMS"
    else
        # Directory does not exist on this system
        printf "%-20s %-12s %-30s\n" "$DIR" "[missing]" "Directory not found"
    fi
done

echo ""
echo "============================================================"
echo "  PYTHON-SPECIFIC DIRECTORY AUDIT (Chosen OSS: Python)"
echo "============================================================"

# --- Python-specific config and library directories ---
PYTHON_DIRS=(
    "/usr/lib/python3"
    "/usr/lib64/python3"
    "/usr/local/lib/python3"
    "/etc/python3"
    "/usr/bin/python3"
    "/usr/local/bin/python3"
)

echo "Checking Python installation directories..."
echo "------------------------------------------------------------"
FOUND_ANY=false  # Track if we find at least one Python directory

for PDIR in "${PYTHON_DIRS[@]}"; do
    if [ -e "$PDIR" ]; then
        # File or directory exists — check if it's a directory or a file
        FOUND_ANY=true
        if [ -d "$PDIR" ]; then
            PERMS=$(ls -ld "$PDIR" | awk '{print $1, $3, $4}')
            SIZE=$(du -sh "$PDIR" 2>/dev/null | cut -f1)
            printf "%-35s %-12s %-30s\n" "$PDIR" "${SIZE:-N/A}" "$PERMS"
        else
            # It's a file (like /usr/bin/python3 which may be a symlink)
            PERMS=$(ls -l "$PDIR" | awk '{print $1, $3, $4}')
            printf "%-35s %-12s %-30s\n" "$PDIR" "[file]" "$PERMS"
            # If it's a symlink, show where it points
            if [ -L "$PDIR" ]; then
                TARGET=$(readlink -f "$PDIR")
                echo "    └── Symlink -> $TARGET"
            fi
        fi
    fi
done

# --- If no Python directories found, try wildcard search ---
if [ "$FOUND_ANY" = false ]; then
    echo "  Standard Python paths not found. Searching with wildcard..."
    # Look for any python3.x versioned directory
    for DIR in /usr/lib/python3.*; do
        if [ -d "$DIR" ]; then
            PERMS=$(ls -ld "$DIR" | awk '{print $1, $3, $4}')
            SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)
            printf "%-35s %-12s %-30s\n" "$DIR" "${SIZE:-N/A}" "$PERMS"
            FOUND_ANY=true
        fi
    done
fi

if [ "$FOUND_ANY" = false ]; then
    echo "  Python does not appear to be installed on this system."
    echo "  Install with: sudo apt install python3  OR  sudo dnf install python3"
fi

echo ""
echo "------------------------------------------------------------"
echo "  SECURITY NOTE:"
echo "  World-writable directories (drwxrwxrwx) like /tmp are normal."
echo "  Sensitive config dirs (/etc) should be owned by root."
echo "  Python libs in /usr/lib should NOT be world-writable."
echo "============================================================"
