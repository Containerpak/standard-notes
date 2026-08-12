FROM ghcr.io/containerpak/gtk:main

ADD --checksum=sha256:c994538e05aee29daf2e6dcebafb5a5d36d7b7a0ad746fd49abd75586e791959 https://github.com/standardnotes/app/releases/download/%40standardnotes/desktop%403.201.21/standard-notes-3.201.21-linux-amd64.deb /tmp/source
COPY icon.png /usr/share/icons/hicolor/128x128/apps/standard-notes.png

RUN apt-get update && \
    apt-get install -y --no-install-recommends libasound2t64 libgtk-3-0 libnss3 && \
    dpkg-deb -x /tmp/source / && \
    cpak-clean-junk
