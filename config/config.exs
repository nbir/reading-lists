# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :reading_lists,
  ecto_repos: [ReadingLists.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :reading_lists, ReadingListsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "YRNSbaDLeDWBPLW4C8+wXDDJ9syfgkBoyTAWZidCZOQQ3EN3CDJQiD2rqDdhqQrs",
  render_errors: [view: ReadingListsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ReadingLists.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
