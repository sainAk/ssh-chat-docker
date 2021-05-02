FROM alpine:3

RUN apk add --no-cache \
    wget \
    && rm -rf /var/cache/apk/*

#Install https://github.com/shazow/ssh-chat/releases
RUN wget -nv https://github.com/shazow/ssh-chat/releases/download/v1.10/ssh-chat-linux_amd64.tgz \
    && tar -xf ssh-chat-linux_amd64.tgz -C /opt \
    && ln -sf /opt/ssh-chat/ssh-chat /usr/local/bin/ssh-chat \
    && rm ssh-chat-linux_amd64.tgz

RUN mkdir -p /root/.ssh
COPY ./confs/ssh-chat-key /root/.ssh/id_rsa

COPY ./confs/admins /root/ 

#watch -n 1 cat /root/chat_logs
RUN touch /root/chat_logs
EXPOSE 2022

CMD ["/usr/local/bin/ssh-chat", "--admin=/root/admins", "--log=/root/chat_logs"]
