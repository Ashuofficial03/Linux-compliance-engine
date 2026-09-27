#!/bin/bash

echo "==========================================="
echo " STARTING LINUX COMPLIANCE ENGINE "
echo "==========================================="
echo ""

# Step 1: Run the Bash Auditing Engine
echo "[*] Initializing system audit..."
./audit_engine.sh

# Step 2: Check if the audit generated the JSON file
if [ -f "audit_results.json" ]; then
    echo "[*] Audit data exported successfully."
    echo "[*] Contacting MongoDB and generating report..."
    echo ""
    
    # Step 3: Run the Python Reporting Engine
    python3 report_engine.py
else
    echo "[!] ERROR: audit_results.json not found. Audit failed."
    exit 1
fi

echo "==========================================="
echo " ENGINE EXECUTION COMPLETE "
echo "==========================================="
