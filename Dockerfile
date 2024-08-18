FROM docker.io/library/ruby:3.1-bookworm

ARG USERNAME=rails
ARG USER_UID=1000
ARG USER_GID=$USER_UID


WORKDIR /rails

COPY . .

# Create the user
RUN groupadd --system --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -s /bin/bash -m $USERNAME \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt-get update \
    && apt-get install -y sudo git vim build-essential \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 440 /etc/sudoers.d/$USERNAME \ 
    && chown -R $USERNAME:$USERNAME db log storage tmp

USER $USERNAME


RUN bundle install

ENTRYPOINT ["./bin/docker-entrypoint"]
# Start the server by default, this can be overwritten at runtime
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
