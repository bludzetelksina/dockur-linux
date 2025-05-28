FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ Europe/Moscow
ENV USER=root


RUN apt-get update && \
    apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    apt-get install -y \
      xfce4 \
      xfce4-goodies \
      tightvncserver \
      novnc \
      websockify && \
    rm -rf /var/lib/apt/lists/*
    ls -l ./config/vnc/xstartup

    mkdir -p config/vnc

    cat << 'EOF' > config/vnc/xstartup
    #!/bin/sh 
    startxfce4 &
    EOF
    chmod +x config/vnc/xstartup


COPY config/vnc/xstartup /root/.vnc/xstartup

RUN chmod +x /root/.vnc/xstartup && chmod 700 /root/.vnc

EXPOSE 5901 6901

CMD ["sh", "-c", "tightvncserver :1 -geometry 1280x800 -depth 24 && websockify --web=/usr/share/novnc/ 6901 localhost:5901"]
