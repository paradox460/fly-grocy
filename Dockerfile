FROM lscr.io/linuxserver/grocy:latest

COPY init-wrapper /

ENTRYPOINT ["/init-wrapper"]
