FROM kalilinux/kali-rolling:latest

# ഇവിടെ നൽകുന്ന പാക്കേജുകൾ എപ്പോഴും കണ്ടെയ്നറിൽ സ്ഥിരമായി ഉണ്ടാകും
RUN apt-get update && apt-get install -y \
    sudo \
    git \
    curl \
    bash-completion \
    e2fsprogs \
    nano \
    net-tools \
    htop \
    && rm -rf /var/lib/apt/lists/*

# സുരക്ഷിതമായ നോൺ-റൂട്ട് യൂസർ നിർമ്മിക്കുന്നു
RUN useradd -ms /bin/bash developer && \
    echo "developer ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# സുരക്ഷാ റൂൾ ഫയൽ കോൺഫിഗറേഷൻ
RUN echo "# Kali Security Policy File" > /etc/kali_security_rules.conf && \
    echo "ALLOW_NMAP=false" >> /etc/kali_security_rules.conf && \
    echo "ALLOW_NETCAT=false" >> /etc/kali_security_rules.conf

RUN mkdir -p /var/log/secure_audit && chmod 733 /var/log/secure_audit

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

USER developer
WORKDIR /home/developer

RUN echo 'PROMPT_COMMAND="history -a"' >> ~/.bashrc && \
    echo 'export HISTFILE="/var/log/secure_audit/bash_history_$(whoami)_\$(date +%Y%m%d).log"' >> ~/.bashrc

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["bash"]
