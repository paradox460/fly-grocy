FROM lscr.io/linuxserver/grocy:latest

COPY init-wrapper /

RUN \
  apk add neovim fish && \
  chsh -s /usr/bin/fish && \
  /usr/bin/fish -C "alias -s vim=nvim"

ENTRYPOINT ["/init-wrapper"]
