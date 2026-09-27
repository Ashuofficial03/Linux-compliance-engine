<div align="center">
  
# 🛡️ Linux Infrastructure Compliance Engine

**An automated compliance engine using Bash, Python, and MongoDB to detect configuration drift and translate raw server states into CIS and ISO 27001 compliance reports.**

[![Tech Stack](https://img.shields.io/badge/Tech_Stack-Bash_|_Python_|_MongoDB-2ea44f?style=for-the-badge)](#)
[![Platform](https://img.shields.io/badge/Platform-CentOS_|_Ubuntu-00599C?style=for-the-badge)](#)

</div>

---

## 📌 The Problem
Manually auditing hundreds of Linux servers is unscalable and error-prone, leaving enterprises constantly vulnerable to configuration drift and compliance fines. Security teams speak in compliance frameworks (CIS, ISO 27001), while IT operators speak in configuration syntax (`grep`, `/etc/ssh/sshd_config`). 

## 💡 The Solution
This project bridges the gap between IT operations and security compliance. It automates Linux security checks, parsing raw server configuration files and dynamically translating those system states into actionable, audit-ready reports.

## ⚙️ Architecture & Workflow

1. **Policy Retrieval (MongoDB):** The engine queries a NoSQL database to fetch the baseline security controls, expected system states, and business framework mappings.
2. **System Auditing (Bash):** A Bash script executes with read-only privileges, using Regular Expressions to parse live Linux configuration files (e.g., `/etc/ssh/sshd_config`).
3. **Data Export (JSON):** Bash compiles the raw pass/fail findings and exports them into a structured JSON artifact.
4. **Contextualization (Python):** A Python script ingests the raw data and queries MongoDB to map the exact misconfigurations to specific CIS Benchmarks and ISO 27001 controls.
5. **Report Generation (stdout):** Python outputs a clean, human-readable terminal dashboard detailing the drift, severity, and exact remediation steps.

---

## 🛠️ Tech Stack
* **Auditing Engine:** Bash, Regex, Linux CLI utilities
* **Reporting Engine:** Python 3, `pymongo`
* **Database:** MongoDB
* **Environment:** CentOS / RHEL / Ubuntu Server

---

## 🚀 Quick Start Guide

### 1. Prerequisites
Ensure you have a Linux environment with Python 3 and MongoDB installed.
```bash
sudo dnf install mongodb-org python3-pip -y
pip3 install pymongo

### 2. Database Initialization
Start the MongoDB service and import the baseline compliance controls.
```bash
sudo systemctl start mongod
mongoimport --db compliance_engine --collection controls --jsonArray --file controls.json```

## 3. Run the master wrapper script to trigger the automated pipeline.

chmod +x run_engine.sh
./run_engine.sh


📊 Sample Output
Failed State (Configuration Drift Detected):

Control ID : CIS_5.2.4
Status     : FAIL
Rule Name  : Ensure SSH Root Login is Disabled
Frameworks : CIS 5.2.4 | ISO A.9.2.1
Severity   : Critical
Fix Action : Edit /etc/ssh/sshd_config and set PermitRootLogin to no.

Passed State (Compliant):

Control ID : CIS_5.2.4
Status     : PASS
Rule Name  : Ensure SSH Root Login is Disabled
Frameworks : CIS 5.2.4 | ISO A.9.2.1
