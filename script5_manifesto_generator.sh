#!/bin/bash
# =============================================================================
# Script 5: Open Source Manifesto Generator
# Author: JIYA KHURANA
# Course: Open Source Software — OSS NGMC Capstone Project
# Description: Asks the user three interactive questions and generates a
#              personalised open-source philosophy statement, saved to a .txt file.
#              Demonstrates: read, string concatenation, file writing with >,
#              date command, and aliases (shown as comments).
# =============================================================================

# --- Alias demonstrations (aliases are defined in .bashrc; shown here as comments) ---
# alias today='date "+%d %B %Y"'
# alias savelog='tee -a ~/oss_manifesto_log.txt'
# Note: aliases defined inside scripts don't persist, but the concept is shown above.

# --- Utility function: print a decorative separator ---
separator() {
    echo "============================================================"
}

separator
echo "     OPEN SOURCE MANIFESTO GENERATOR                      "
echo "     Author:JIYA KHURANA | Project: Python Audit          "
separator
echo ""
echo "  Answer three questions to generate your personal"
echo "  open-source manifesto. Be honest and thoughtful."
echo ""

# --- Interactive input using 'read' with prompts ---

# Question 1: An OSS tool the user actually uses
read -p "  1. Name one open-source tool you use every day: " TOOL

# Validate that they actually typed something
while [ -z "$TOOL" ]; do
    echo "  (Please enter a tool name — e.g., Python, Firefox, Git)"
    read -p "  1. Name one open-source tool you use every day: " TOOL
done

# Question 2: What 'freedom' means to them in one word
read -p "  2. In one word, what does 'freedom' mean to you in software? " FREEDOM

while [ -z "$FREEDOM" ]; do
    echo "  (Please enter one word — e.g., control, transparency, access)"
    read -p "  2. In one word, what does 'freedom' mean to you? " FREEDOM
done

# Question 3: Something they'd build and share
read -p "  3. Name one thing you would build and share freely with the world: " BUILD

while [ -z "$BUILD" ]; do
    echo "  (e.g., a language translator, a budgeting app, a learning tool)"
    read -p "  3. Name one thing you would build and share freely: " BUILD
done

echo ""
echo "  Generating your manifesto..."
echo ""

# --- Capture date and username for the output file ---
DATE=$(date '+%d %B %Y')           # Formatted date: e.g., 15 October 2024
TIME=$(date '+%H:%M')              # Time of generation
AUTHOR=$(whoami)                   # System username
OUTPUT="manifesto_${AUTHOR}.txt"   # Dynamic filename based on username

# --- Compose the manifesto using string concatenation and heredoc ---
# Using heredoc (<<EOF) for clean multi-line output to file

cat > "$OUTPUT" << EOF
============================================================
        OPEN SOURCE MANIFESTO
        by JIYA KHURANA (${AUTHOR})
        Generated on: ${DATE} at ${TIME}
============================================================

Every day, I rely on ${TOOL} — a piece of software that
someone built, refined, and gave away freely. They did not
have to do that. They chose to. That choice is the
foundation of the world I work in.

To me, freedom in software means ${FREEDOM}. Not just the
freedom to run a program, but the freedom to look inside it,
to understand it, to change it, and to pass it forward.
Proprietary software asks you to trust without seeing. Open
source shows you everything and says: verify it yourself.

If I could build anything and share it freely, it would be
${BUILD}. I would release it with an open license — not
because I have to, but because the best ideas grow when
more people can touch them. The tools I use today exist
because someone before me made that same choice.

Python, the software I chose to audit for this project,
represents exactly this spirit. Guido van Rossum created it
not for profit, but to make programming more human. The PSF
License ensures that Python will never be locked away. Every
programmer who has ever typed 'import this' has read the Zen
of Python — 18 aphorisms about clarity, simplicity, and
openness. That is the philosophy I carry forward.

Open source is not charity. It is the recognition that
software, like knowledge itself, becomes more valuable when
it is shared, not when it is hoarded.

                                        — JIYA KHURANA
                                          ${DATE}

============================================================
  "Given enough eyeballs, all bugs are shallow."
                                  — Eric S. Raymond
============================================================
EOF

# --- Display the generated manifesto to the terminal ---
echo ""
separator
echo "  YOUR OPEN SOURCE MANIFESTO"
separator
cat "$OUTPUT"
echo ""
separator
echo "  Manifesto saved to: $(pwd)/${OUTPUT}"
separator
