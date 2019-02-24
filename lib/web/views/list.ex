defmodule ReadingListsWeb.ListView do
  use ReadingListsWeb, :view
  alias ReadingListsWeb.ListView

  def render("index.json", %{lists: lists}) do
    %{data: render_many(lists, ListView, "list.json")}
  end

  def render("show.json", %{list: list}) do
    %{data: render_one(list, ListView, "list.json")}
  end

  def render("list.json", %{list: list}) do
    %{
      id: list.id,
      title: list.title,
      is_starred: list.is_starred,
      inserted_at: list.inserted_at,
      updated_at: list.updated_at
    }
  end
end
