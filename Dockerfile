FROM erlang:22

# elixir expects utf8.
ENV ELIXIR_VERSION="v1.9.2" \
  NODEJS_VERSION=12.13.0 \
  ASDF_VERSION=v0.5.1 \
  PATH=/asdf/bin:/asdf/shims:$PATH \
  REFRESHED_AT=2019-10-24 \
  LANG=C.UTF-8 \
  LANGUAGE=C:en \
  LC_ALL=C.UTF-8 \
  BUILD_ENV=true \
  HOME=/app \
  DEBIAN_FRONTEND=noninteractive \
  TERM=xterm

RUN set -xe \
  && ELIXIR_DOWNLOAD_URL="https://github.com/elixir-lang/elixir/archive/${ELIXIR_VERSION}.tar.gz" \
  && ELIXIR_DOWNLOAD_SHA256="02aaa3ffd21f9cf51aceb3aa5a5bc2c1e2636b1611867e44f19693dcf856e25c" \
  && curl -fSL -o elixir-src.tar.gz $ELIXIR_DOWNLOAD_URL \
  && echo "$ELIXIR_DOWNLOAD_SHA256  elixir-src.tar.gz" | sha256sum -c - \
  && mkdir -p /usr/local/src/elixir \
  && tar -xzC /usr/local/src/elixir --strip-components=1 -f elixir-src.tar.gz \
  && rm elixir-src.tar.gz \
  && cd /usr/local/src/elixir \
  && make install clean

WORKDIR /app

RUN apt-get update -y && \
  apt-get install -y apt-transport-https ca-certificates

RUN git clone https://github.com/asdf-vm/asdf.git /asdf --branch $ASDF_VERSION && \
  echo 'source /asdf/asdf.sh' >> /etc/bash.bashrc

RUN asdf plugin-add nodejs && \
  bash /asdf/plugins/nodejs/bin/import-release-team-keyring
RUN asdf install nodejs $NODEJS_VERSION && \
  asdf global nodejs $NODEJS_VERSION

# Application dependencies. There's usually a dependency for node to have
# python for building Phoenix assets. We also use Yarn instead of npm
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" >> /etc/apt/sources.list.d/yarn.list && \
  apt-get update -y && \
  apt-get install -y python && \
  apt-get install -y --no-install-recommends yarn

COPY . /app

CMD ["/bin/bash"]
