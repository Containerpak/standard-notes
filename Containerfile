FROM ubuntu:26.04 AS source

ADD --checksum=sha256:c994538e05aee29daf2e6dcebafb5a5d36d7b7a0ad746fd49abd75586e791959 https://github.com/standardnotes/app/releases/download/%40standardnotes/desktop%403.201.21/standard-notes-3.201.21-linux-amd64.deb /tmp/source

FROM ghcr.io/containerpak/gtk3:main

COPY icon.png /usr/share/icons/hicolor/128x128/apps/standard-notes.png

RUN --mount=type=bind,from=source,source=/tmp/source,target=/run/standard-notes.deb \
    apt-get update && \
    apt-get install -y --no-install-recommends /run/standard-notes.deb && \
    ln -sf '/opt/Standard Notes/standard-notes' /usr/bin/standard-notes && \
    cpak-clean-junk
