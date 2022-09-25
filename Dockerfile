FROM debian:bullseye-slim as deps
# ENV TZ=Europe/London
WORKDIR /app
RUN apt update && \
    apt install -yq build-essential git clang g++ llvm \
    libstdc++-10-dev zlib1g-dev libssl-dev cmake

FROM deps AS builder
RUN git clone https://github.com/rui314/mold.git && \
    cd mold && \
    git checkout --quiet v1.4.2 && \
    make -j$(nproc) CXX=clang++ && \
    make install

FROM gcr.io/distroless/static:nonroot
WORKDIR /
COPY --from=builder --chown=nonroot:nonroot /usr/local/bin/mold /mold
COPY config.toml /config.toml
