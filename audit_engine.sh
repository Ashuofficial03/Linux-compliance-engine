#!/bin/bash

# Define the control parameters
FILE="/etc/ssh/sshd_config"
REGEX="^PermitRootLogin\s+no"
CONTROL_ID="CIS_5.2.4"
OUTPUT_FILE="audit_results.json"

echo "Starting compliance audit on $FILE..."

# 1. Check if the configuration file actually exists
if [ ! -f "$FILE" ]; then
  STATUS="FAIL_FILE_NOT_FOUND"

# 2. Use grep to evaluate the Regex against the file
elif grep -Eq "$REGEX" "$FILE"; then
  STATUS="PASS"
else
  STATUS="FAIL"
fi

# 3. Export the raw data to a JSON array for Python
cat <<EOF > $OUTPUT_FILE
[
  {
    "control_id": "$CONTROL_ID",
    "status": "$STATUS",
    "file_checked": "$FILE"
  }
]
EOF

echo "Audit complete. Result: $STATUS"
echo "Raw data exported to $OUTPUT_FILE"
