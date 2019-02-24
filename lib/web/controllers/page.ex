defmodule ReadingListsWeb.PageController do
  use ReadingListsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
