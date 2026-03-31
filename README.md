# oss-audit-[24BAI10467]

## Open Source Software Audit — Capstone Project
**Course:** Open Source Software (OSS NGMC)
**Student:** JIYA KHURANA
**Registration Number:** 24BAI10467
**Chosen Software:** Python (PSF License)

---

## Project Overview

This repository contains all shell scripts and supporting materials for the **Open Source Audit** capstone project. The audit examines **Python** — its origin, philosophy, licensing, Linux footprint, ecosystem, and comparison with proprietary alternatives.

---

## Repository Structure

```
oss-audit-[24BAI10467]/
├── script1_system_identity.sh          # System Identity Report
├── script2_package_inspector.sh        # FOSS Package Inspector
├── script3_disk_permission_auditor.sh  # Disk and Permission Auditor
├── script4_log_analyzer.sh             # Log File Analyzer
├── script5_manifesto_generator.sh      # Open Source Manifesto Generator
├── README.md                           # This file
```

---

## Scripts Description

### Script 1 — System Identity Report
**File:** `script1_system_identity.sh`

Displays a formatted welcome screen with system information: Linux distro name, kernel version, logged-in user, home directory, uptime, current date/time, and a message identifying the OS license and Python's PSF license.

**Concepts used:** Variables, `echo`, command substitution `$()`, `case` statement for OS detection, basic output formatting.

---

### Script 2 — FOSS Package Inspector
**File:** `script2_package_inspector.sh`

Checks whether a given open-source package is installed on the system, prints its version, license, and summary from the package manager, and displays a philosophy note about that specific package.

**Concepts used:** `if-then-else`, `case` statement, `rpm -qi` / `dpkg -l`, pipes with `grep`, command-line arguments (`$1`).

---

### Script 3 — Disk and Permission Auditor
**File:** `script3_disk_permission_auditor.sh`

Loops through a list of important system directories and reports how much disk space each uses, and the owner, group, and permissions of each directory. Also audits Python-specific installation directories.

**Concepts used:** `for` loop, `du -sh`, `ls -ld`, `awk` to extract fields, conditional checks.

---

### Script 4 — Log File Analyzer
**File:** `script4_log_analyzer.sh`

Reads a log file line by line, counts how many lines contain a specified keyword (default: `error`), and prints a summary with the last 5 matching lines. Includes a do-while style retry if the file is empty.

**Concepts used:** `while read` loop, `if-then`, counter variables `$(())`, command-line arguments, `grep`, `tail`, retry logic.

---

### Script 5 — Open Source Manifesto Generator
**File:** `script5_manifesto_generator.sh`

Interactively asks the user three questions and composes a personalised open-source philosophy statement using their answers, then saves it to a `.txt` file named after the current user.

**Concepts used:** `read` for user input, string concatenation, heredoc (`<< EOF`), file writing with `>`, `date` command, alias demonstration.

---

## How to Run Each Script on Linux

### Prerequisites
- A Linux system (Ubuntu, Fedora, Debian, or any major distro)
- Bash shell (version 4.0 or higher — check with `bash --version`)
- No additional dependencies required for any script

### Step 1 — Clone the repository
```bash
git clone https://github.com/coder200623/Open-Source-project
cd oss-audit-[24BAI10467]
```

### Step 2 — Make scripts executable
```bash
chmod +x script1_system_identity.sh
chmod +x script2_package_inspector.sh
chmod +x script3_disk_permission_auditor.sh
chmod +x script4_log_analyzer.sh
chmod +x script5_manifesto_generator.sh
```

### Step 3 — Run each script

**Script 1 — System Identity Report**
```bash
./script1_system_identity.sh
```
No arguments needed. Displays system information automatically.

---

**Script 2 — FOSS Package Inspector**
```bash
# Inspect Python (default audit subject)
./script2_package_inspector.sh python3

# Inspect any other OSS package
./script2_package_inspector.sh git
./script2_package_inspector.sh firefox
./script2_package_inspector.sh vlc
```

---

**Script 3 — Disk and Permission Auditor**
```bash
./script3_disk_permission_auditor.sh
```
No arguments needed. Audits standard system directories and Python paths automatically.

---

**Script 4 — Log File Analyzer**
```bash
# Basic usage — search for 'error' in syslog
./script4_log_analyzer.sh /var/log/syslog

# Search for a specific keyword
./script4_log_analyzer.sh /var/log/syslog warning
./script4_log_analyzer.sh /var/log/auth.log failed

# On Fedora/RHEL systems
./script4_log_analyzer.sh /var/log/messages error
```

---

**Script 5 — Open Source Manifesto Generator**
```bash
./script5_manifesto_generator.sh
```
Interactive — will prompt you for three answers. The manifesto is saved to `manifesto_<username>.txt` in the current directory.

---

## Dependencies

All scripts use only standard Linux utilities available on any distribution:

| Utility | Purpose | Available By Default |
|---------|---------|----------------------|
| `bash` | Shell interpreter | Yes |
| `uname` | Kernel/OS info | Yes |
| `whoami` | Current user | Yes |
| `uptime` | System uptime | Yes |
| `date` | Date/time | Yes |
| `du` | Disk usage | Yes |
| `ls` | File/dir info | Yes |
| `awk` | Text processing | Yes |
| `grep` | Pattern matching | Yes |
| `tail` | Last N lines | Yes |
| `rpm` | Package info (RPM systems) | On RHEL/Fedora |
| `dpkg` | Package info (DEB systems) | On Debian/Ubuntu |

No external packages need to be installed.

---

## About Python (Audited Software)

Python is a high-level, general-purpose programming language first released by Guido van Rossum in 1991. It is distributed under the **Python Software Foundation (PSF) License**, an OSI-approved permissive license that allows use in both open-source and proprietary software.

Key facts:
- **License:** PSF License 2.0 (permissive, OSI-approved)
- **Repository:** https://github.com/python/cpython
- **Governance:** Python Software Foundation (PSF)
- **Package Manager:** pip (Python Package Index — PyPI)
- **Linux package name:** `python3` (most distros)

---

## Academic Integrity Note

All scripts in this repository are original work written by JIYA KHURANA, 24BAI10467. All comments and logic are the author's own. Scripts are designed to run on real Linux systems and demonstrate genuine understanding of shell scripting concepts as required by the OSS NGMC course rubric.
