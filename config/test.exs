use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :reading_lists, ReadingListsWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :reading_lists, ReadingLists.Repo,
  username: "postgres",
  password: "postgres",
  database: "reading_lists_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
