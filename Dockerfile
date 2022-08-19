FROM rust:latest

RUN apt-get update && apt-get install -qy clang libudev-dev nodejs npm tmux vim neovim git netcat zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

RUN rustup component add rustfmt

WORKDIR /work

RUN sh -c "$(curl -sSfL https://release.solana.com/v1.10.32/install)"

RUN npm install -g yarn && npm i -g @project-serum/anchor-cli
RUN cargo install --git https://github.com/project-serum/anchor --tag v0.24.2 anchor-cli --locked

RUN mkdir -p /root/.config/solana
RUN solana-keygen new --silent --no-bip39-passphrase -o /root/.config/solana/id.json

ENV PATH="/root/.local/share/solana/install/active_release/bin:${PATH}"

CMD /bin/zsh
