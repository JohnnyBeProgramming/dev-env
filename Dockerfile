# Run a development environment inside a docker
FROM alpine:3.12

# Install development packages
RUN apk add -U --no-cache \
    curl jq git git-perl neovim \
    zsh tmux openssh-client ncurses \
    bash su-exec \
    curl less wget shadow \
    docker py-pip

# Create a user and group called 'sandbox'
RUN adduser -S sandbox -s /bin/zsh
ENV HOME /home/sandbox
WORKDIR $HOME

# Install zshell extensions
RUN curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | zsh || true    

# Copy home folder contents
COPY ./home $HOME

# Set working folder for the user
WORKDIR /workspace

ENTRYPOINT [ "/bin/bash", "-C", "/home/sandbox/utils/entrypoint.sh" ]