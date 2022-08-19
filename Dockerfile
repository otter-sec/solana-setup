FROM rust:latest

RUN apt-get update && apt-get install -y clang libudev-dev nodejs npm tmux vim neovim git
RUN rustup component add rustfmt

RUN sh -c "$(curl -sSfL https://release.solana.com/stable/install)"
ENV PATH="/root/.local/share/solana/install/releases/stable/solana-release/bin/:${PATH}"

WORKDIR /work

RUN npm install -g yarn && npm i -g @project-serum/anchor-cli
RUN cargo install --git https://github.com/project-serum/anchor --tag v0.24.2 anchor-cli --locked

RUN sh -c "$(curl -sSfL https://release.solana.com/v1.10.32/install)"
ENV PATH="/root/.local/share/solana/install/active_release/bin:${PATH}"
RUN mkdir -p /root/.config/solana
RUN solana-keygen new --silent --no-bip39-passphrase -o /root/.config/solana/id.json

CMD /bin/bash
