FROM ubuntu:22.04 AS installer

WORKDIR /install-tl

RUN apt-get update && apt-get install -y \
    wget     \
    xz-utils \
    perl     \
    fontconfig

RUN wget -nv https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
    tar -xzf ./install-tl-unx.tar.gz --strip-components=1

RUN ./install-tl -scheme scheme-basic \
    --no-interaction \
    -no-doc-install  \
    -no-src-install

RUN /usr/local/texlive/*/bin/*/tlmgr path add

RUN tlmgr install \
    collection-langjapanese \
    collection-fontsrecommended \
    collection-latexextra \
    latexmk



# Application Environments
FROM ubuntu:22.04 AS default

WORKDIR /workdir

COPY --from=installer /usr/local/texlive /usr/local/texlive

RUN apt-get update && apt-get install -y \
    perl \
    wget \
    ghostscript \
    && rm -rf /var/lib/apt/lists/*

RUN /usr/local/texlive/*/bin/*/tlmgr path add

RUN tlmgr install \
    collection-mathscience \
    collection-luatex      \
    collection-pictures

CMD ["bash"]
