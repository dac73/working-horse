FROM registry.fedoraproject.org/fedora:29

ENV NAME=working-horse VERSION=f29

COPY extra-packages /tmp
RUN dnf -y install $(< /tmp/extra-packages)
RUN pip3 install awscli lolcat

ARG THIS_UID=1000
ARG THIS_USER=cow

# Replace $THIS_UID with your user / group id
RUN export uid=$THIS_UID gid=$THIS_UID && \
    mkdir -p /home/$THIS_USER && \
    echo "$THIS_USER:x:${uid}:${gid}:${THIS_USER^},,,:/home/$THIS_USER:/bin/bash" >> /etc/passwd && \
    echo "$THIS_USER:x:${uid}:" >> /etc/group && \
    echo "$THIS_USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$THIS_USER && \
    chmod 0440 /etc/sudoers.d/$THIS_USER && \
    chown ${uid}:${gid} -R /home/$THIS_USER

USER $THIS_USER
ENV HOME /home/$THIS_USER


CMD /bin/sh
