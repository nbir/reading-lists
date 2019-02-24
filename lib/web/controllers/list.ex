defmodule ReadingListsWeb.ListController do
  use ReadingListsWeb, :controller

  alias ReadingLists.Models.List
  alias ReadingLists.ReadingLists.Lists

  action_fallback ReadingListsWeb.FallbackController

  def index(conn, _params) do
    lists = Lists.list_lists()
    render(conn, "index.json", lists: lists)
  end

  def show(conn, %{"id" => id}) do
    case Lists.get_list(id) do
      nil -> send_resp(conn, 404, "List not found")
      list -> render(conn, "show.json", list: list)
    end
  end

  def create(conn, %{"list" => list_params}) do
    with {:ok, %List{} = list} <- Lists.create_list(list_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.list_path(conn, :show, list))
      |> render("show.json", list: list)
    end
  end

  def update(conn, %{"id" => id, "list" => list_params}) do
    list = Lists.get_list!(id)

    with {:ok, %List{} = list} <- Lists.update_list(list, list_params) do
      render(conn, "show.json", list: list)
    end
  end

  def delete(conn, %{"id" => id}) do
    list = Lists.get_list!(id)

    with {:ok, %List{}} <- Lists.delete_list(list) do
      send_resp(conn, :no_content, "")
    end
  end
end
