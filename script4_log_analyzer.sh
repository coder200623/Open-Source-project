#!/bin/bash
# =============================================================================
# Script 4: Log File Analyzer
# Author: JIYA KHURANA
# Course: Open Source Software — OSS NGMC Capstone Project
# Description: Reads a log file line by line, counts occurrences of a keyword
#              (default: 'error'), and prints a summary with matching lines.
#              Demonstrates: while-read loop, if-then, counter variables,
#              command-line arguments, and retry logic.
# Usage: ./script4_log_analyzer.sh <logfile> [keyword]
#        Example: ./script4_log_analyzer.sh /var/log/syslog error
# =============================================================================

# --- Command-line arguments ---
LOGFILE=$1                  # First argument: path to log file
KEYWORD=${2:-"error"}       # Second argument: keyword to search (default: 'error')
COUNT=0                     # Counter for matching lines
RETRY_LIMIT=3               # Maximum number of retries if file is empty
RETRY_COUNT=0               # Current retry attempt

echo "============================================================"
echo "         LOG FILE ANALYZER                                 "
echo "============================================================"

# --- Validate that a log file argument was provided ---
if [ -z "$LOGFILE" ]; then
    echo "  ERROR: No log file specified."
    echo "  Usage: $0 <logfile> [keyword]"
    echo ""
    echo "  Common log files to try:"
    echo "    /var/log/syslog         (Debian/Ubuntu)"
    echo "    /var/log/messages       (Fedora/RHEL)"
    echo "    /var/log/auth.log       (Authentication logs)"
    echo "    /var/log/kern.log       (Kernel logs)"
    exit 1
fi

# --- Check if file exists ---
if [ ! -f "$LOGFILE" ]; then
    echo "  ERROR: File '$LOGFILE' not found."
    exit 1
fi

echo "  Log File  : $LOGFILE"
echo "  Keyword   : '$KEYWORD' (case-insensitive)"
echo "------------------------------------------------------------"

# --- Do-while style retry loop if file is empty ---
# Bash has no native do-while, so we use while with a break condition
while true; do
    # Check if file is empty (zero bytes)
    if [ ! -s "$LOGFILE" ]; then
        RETRY_COUNT=$((RETRY_COUNT + 1))
        echo "  WARNING: File is empty (attempt $RETRY_COUNT of $RETRY_LIMIT)."

        # Stop retrying after hitting the limit
        if [ $RETRY_COUNT -ge $RETRY_LIMIT ]; then
            echo "  File remains empty after $RETRY_LIMIT attempts. Exiting."
            exit 1
        fi

        echo "  Waiting 2 seconds before retry..."
        sleep 2   # Wait for log file to potentially get written to
    else
        break     # File has content — exit the retry loop
    fi
done

echo "  Scanning log file..."
echo ""

# --- Main analysis: while-read loop to process file line by line ---
while IFS= read -r LINE; do
    # if-then: check if current line contains the keyword (case-insensitive with -i)
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))   # Increment the counter
    fi
done < "$LOGFILE"              # Feed the file into the while loop via redirection

# --- Display the summary ---
echo "------------------------------------------------------------"
echo "  ANALYSIS SUMMARY"
echo "------------------------------------------------------------"
echo "  Total lines matched   : $COUNT"
echo "  Keyword searched      : '$KEYWORD'"
echo "  File scanned          : $LOGFILE"
echo "  File size             : $(du -sh "$LOGFILE" | cut -f1)"
echo "  Total lines in file   : $(wc -l < "$LOGFILE")"
echo ""

# --- Show the last 5 matching lines using grep + tail ---
if [ $COUNT -gt 0 ]; then
    echo "------------------------------------------------------------"
    echo "  LAST 5 MATCHING LINES (most recent occurrences):"
    echo "------------------------------------------------------------"
    # grep for the keyword (case-insensitive), then show only the last 5 results
    grep -i "$KEYWORD" "$LOGFILE" | tail -5
else
    echo "  No lines matching '$KEYWORD' were found in this log file."
fi

echo ""
echo "------------------------------------------------------------"
echo "  Python OSS Note: Python's logging module writes logs in"
echo "  a standardised format. Open-source transparency means"
echo "  anyone can audit these logs — no black boxes."
echo "============================================================"
