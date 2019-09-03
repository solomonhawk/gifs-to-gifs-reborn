test:
	MIX_ENV=test mix test

test.watch:
	mix test.watch

coverage:
	MIX_ENV=test mix coveralls

coverage.html:
	MIX_ENV=test mix coveralls.html

assets:
	cd apps/ui/assets && yarn watch

run:
	PORT=4000 mix phx.server

iex:
	PORT=4000 iex -S mix phx.server

.DEFAULT: test
.PHONY: test test.watch coverage coverage.html assets
