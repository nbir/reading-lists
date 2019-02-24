deps:
	mix deps.get

db:
	mix ecto.setup

s:
	mix phx.server

t:
	mix test --trace test/
