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

run:
	PORT=4000 mix phx.server

iex:
	PORT=4000 iex -S mix phx.server

.DEFAULT: test
.PHONY: t tw types cov cov.html assets
