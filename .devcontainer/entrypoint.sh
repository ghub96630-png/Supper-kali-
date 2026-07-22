#!/bin/bash

# ഫയൽ ലോക്ക് തുറന്ന് റൂളുകൾ റീഡ് ചെയ്യുന്നു
chattr -i /etc/kali_security_rules.conf 2>/dev/null || true

if [ -f /etc/kali_security_rules.conf ]; then
    source /etc/kali_security_rules.conf
fi

# Nmap പെർമിഷൻ ചെക്ക് ചെയ്യുന്നു
if [ "$ALLOW_NMAP" = "true" ]; then
    echo "[INFO] Nmap is allowed by policy. Installing..."
    apt-get update && apt-get install -y nmap >/dev/null 2>&1 || true
else
    echo "[INFO] Nmap is restricted by policy. Removing..."
    apt-get purge -y nmap >/dev/null 2>&1 || true
fi

# Netcat പെർമിഷൻ ചെക്ക് ചെയ്യുന്നു
if [ "$ALLOW_NETCAT" = "true" ]; then
    echo "[INFO] Netcat is allowed by policy. Installing..."
    apt-get update && apt-get install -y netcat-openbsd >/dev/null 2>&1 || true
else
    echo "[INFO] Netcat is restricted by policy. Removing..."
    apt-get purge -y netcat-openbsd >/dev/null 2>&1 || true
fi

# സിസ്റ്റം സ്റ്റാർട്ട് ആയ ഉടൻ ആ ഫയൽ വീണ്ടും ആർക്കും മാറ്റാൻ പറ്റാത്തവിധം ലോക്ക് ചെയ്യുന്നു (Immutable)
chattr +i /etc/kali_security_rules.conf 2>/dev/null || true

# മെയിൻ കമാൻഡിലേക്ക് പാസ്സ് ചെയ്യുന്നു
exec "$@"
