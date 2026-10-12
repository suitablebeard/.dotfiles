# Here are the two commands you need to know for this:
# To build the image:
# docker build -t dotfiles-tester:latest .
# To run the container:
# docker run --rm -it dotfiles-tester:latest


FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV HOME=/home/tester
ENV USER=tester

RUN apt-get update && apt-get install -y \
    sudo \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root test user named 'tester' with sudo privileges
RUN useradd -ms /bin/bash tester && \
    echo "tester ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

WORKDIR /home/tester

COPY --chown=tester:tester . /home/tester/.dotfiles

WORKDIR /home/tester/.dotfiles/installers

USER tester

# Set the default command to an interactive bash shell
CMD ["sudo", "./install_linux.sh"]
