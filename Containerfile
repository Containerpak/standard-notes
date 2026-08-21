FROM ubuntu:26.04 AS source

ADD --checksum=sha256:b51d6895ccef371a61b68996ddefeb6fe107a65f95c71490c610cd9349d3d1cb https://github.com/standardnotes/app/releases/download/%40standardnotes/desktop%403.202.0/standard-notes-3.202.0-linux-amd64.deb /tmp/source

FROM ghcr.io/containerpak/gtk3:main

COPY icon.png /usr/share/icons/hicolor/128x128/apps/standard-notes.png

RUN --mount=type=bind,from=source,source=/tmp/source,target=/run/standard-notes.deb \
    apt-get update && \
    apt-get install -y --no-install-recommends /run/standard-notes.deb && \
    ln -sf '/opt/Standard Notes/standard-notes' /usr/bin/standard-notes && \
    cpak-clean-junk
