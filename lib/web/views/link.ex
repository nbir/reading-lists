defmodule ReadingListsWeb.LinkView do
  use ReadingListsWeb, :view
  alias ReadingListsWeb.LinkView

  def render("index.json", %{links: links}) do
    %{data: render_many(links, LinkView, "link.json")}
  end

  def render("show.json", %{link: link}) do
    %{data: render_one(link, LinkView, "link.json")}
  end

  def render("link.json", %{link: link}) do
    %{
      id: link.id,
      url: link.url,
      title: link.title,
      is_starred: link.is_starred,
      inserted_at: link.inserted_at,
      updated_at: link.updated_at
    }
  end
end
