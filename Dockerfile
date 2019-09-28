#
# This Dockerfile builds a release and then starts the app.
#
FROM bitwalker/alpine-elixir-phoenix:1.9.0 as releaser

WORKDIR /app

# Install Hex + Rebar
RUN mix do local.hex --force
RUN apk add yarn

COPY config/ /app/config/
COPY mix.exs /app/
COPY mix.* /app/

COPY apps/game/mix.exs /app/apps/game/
COPY apps/ui/mix.exs /app/apps/ui/

ADD apps/ui/assets/package.json apps/ui/assets/yarn.lock /tmp/

ENV MIX_ENV=prod
RUN mix do deps.get --only $MIX_ENV, deps.compile

COPY . /app/

WORKDIR /app/apps/ui
RUN mix compile
RUN yarn --frozen-lockfile --cwd ./assets install
RUN yarn --cwd ./assets run deploy
RUN mix phx.digest

WORKDIR /app
RUN MIX_ENV=prod mix release

########################################################################

FROM bitwalker/alpine-elixir-phoenix:1.9.0

EXPOSE 4000
ENV PORT=4000 \
  MIX_ENV=prod \
  SHELL=/bin/bash

WORKDIR /app
COPY --from=releaser app/_build/prod/rel/gifs_to_gifs .
COPY --from=releaser app/bin/ ./bin

CMD ["./bin/start"]
