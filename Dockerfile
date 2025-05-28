FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Moscow   # <-- Укажи нужный часовой пояс

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

COPY config/vnc/xstartup /root/.vnc/xstartup

EXPOSE 5901 6901

CMD ["sh", "-c", "tightvncserver :1 -geometry 1280x800 -depth 24 && websockify --web=/usr/share/novnc/ 6901 localhost:5901"]
