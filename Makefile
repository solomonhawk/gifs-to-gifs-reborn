t:
	MIX_ENV=test mix test

tw:
	mix test.watch

types:
	mix dialyzer

cov:
	MIX_ENV=test mix coveralls

cov.html:
	MIX_ENV=test mix coveralls.html

assets:
	cd apps/ui/assets && yarn watch

build-assets:
	cd apps/ui/assets && yarn deploy

dev:
	PORT=4000 mix phx.server

iex:
	PORT=4000 iex -S mix phx.server

ssh:
	ssh root@gifme-web

digest:
	MIX_ENV=prod mix phx.digest

release: build-assets digest
	MIX_ENV=prod mix release --overwrite

docker-build:
	docker build --tag=gifme .

docker:
	docker run -t -i -p 4000:4000 --rm --env-file ./config/env.prod gifme:latest

run:
	_build/prod/rel/gifs_to_gifs/bin/gifs_to_gifs start_iex

check-ci:
	circleci config validate

process-ci:
	circleci config process .circleci/config.yml

.DEFAULT: test
.PHONY: t tw types cov cov.html assets build-assets dev iex ssh digest release docker-build docker run
