FROM ubuntu:16.04

RUN sed -i 's/^# deb-src/deb-src/g' /etc/apt/sources.list

RUN apt-get update
RUN apt-get install -y build-essential devscripts
RUN apt-get build-dep -y libpam-modules

WORKDIR /tmp/build
RUN apt-get source libpam-modules

WORKDIR /tmp/build/pam-1.1.8
ADD ./patches/pam_tty_audit.patch ./debian/patches-applied/pam_tty_audit.patch
RUN echo 'pam_tty_audit.patch' >> ./debian/patches-applied/series
ENV DEBFULLNAME='root'
ENV DEBEMAIL='root@localhost'
RUN dch -v '1.1.8-3.2ubuntu2.1-p1' 'Fix pam_tty_audit log_passwd support and regression.' && dch -r xenial
RUN dpkg-buildpackage -us -uc

CMD [ "bash" ]
