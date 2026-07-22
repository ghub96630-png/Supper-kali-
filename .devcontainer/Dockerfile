FROM kalilinux/kali-rolling:latest

# അടിസ്ഥാന ടൂളുകളും സുരക്ഷാ ഫയൽ സിസ്റ്റം ടൂളുകളും ഇൻസ്റ്റാൾ ചെയ്യുക
RUN apt-get update && apt-get install -y \
    sudo \
    git \
    curl \
    bash-completion \
    e2fsprogs \
    && rm -rf /var/lib/apt/lists/*

# സുരക്ഷിതമായ നോൺ-റൂട്ട് യൂസർ ('developer') നിർമ്മിക്കുന്നു
RUN useradd -ms /bin/bash developer && \
    echo "developer ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# സുരക്ഷാ റോളുകൾ വെക്കാനുള്ള ഫയൽ നിർമ്മിക്കുന്നു (ബിൽഡ് സമയത്ത് chattr ഉപയോഗിക്കുന്നില്ല)
RUN echo "# Kali Security Policy File" > /etc/kali_security_rules.conf && \
    echo "ALLOW_NMAP=false" >> /etc/kali_security_rules.conf && \
    echo "ALLOW_NETCAT=false" >> /etc/kali_security_rules.conf

# ലോഗ് ഫോൾഡർ നിർമ്മിക്കുന്നു
RUN mkdir -p /var/log/secure_audit && chmod 733 /var/log/secure_audit

# ബൂട്ട് സമയത്ത് റൂളുകൾ പരിശോധിക്കാൻ എൻട്രിപോയിന്റ് സ്ക്രിപ്റ്റ് കോപ്പി ചെയ്യുന്നു
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

USER developer
WORKDIR /home/developer

# കമാൻഡ് ലോഗിംഗ് സെറ്റ് ചെയ്യുന്നു
RUN echo 'PROMPT_COMMAND="history -a"' >> ~/.bashrc && \
    echo 'export HISTFILE="/var/log/secure_audit/bash_history_$(whoami)_\$(date +%Y%m%d).log"' >> ~/.bashrc

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["bash"]
