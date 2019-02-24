defmodule ReadingLists.Repo do
  use Ecto.Repo,
    otp_app: :reading_lists,
    adapter: Ecto.Adapters.Postgres
end
