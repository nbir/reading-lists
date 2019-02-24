defmodule ReadingListsWeb.LinkControllerTest do
  use ReadingListsWeb.ConnCase

  alias ReadingLists.Models.Link
  alias ReadingLists.ReadingLists.Links
  alias ReadingLists.ReadingLists.Lists

  @create_attrs %{
    is_starred: true,
    title: "some title",
    url: "some url"
  }
  @update_attrs %{
    is_starred: false,
    title: "some updated title",
    url: "some updated url"
  }
  @invalid_attrs %{is_starred: nil, title: nil, url: nil}

  def fixture(:list) do
    {:ok, list} =
      Lists.create_list(%{
        is_starred: false,
        title: "some title"
      })

    list
  end

  def fixture(:link, %{id: list_id}) do
    {:ok, link} = Links.create_link(Map.put(@create_attrs, :list_id, list_id))
    link
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    setup [:create_link]

    test "lists all links", %{conn: conn, list: list, link: link} do
      conn = get(conn, Routes.link_path(conn, :index), %{list_id: list.id})

      assert json_response(conn, 200)["data"] == [
               %{
                 "id" => link.id,
                 "title" => link.title,
                 "url" => link.url,
                 "is_starred" => link.is_starred,
                 "inserted_at" => DateTime.to_iso8601(link.inserted_at),
                 "updated_at" => DateTime.to_iso8601(link.updated_at)
               }
             ]
    end
  end

  describe "create link" do
    setup [:create_list]

    test "renders link when data is valid", %{conn: conn, list: list} do
      conn =
        post(conn, Routes.link_path(conn, :create),
          link: Map.put(@create_attrs, :list_id, list.id)
        )

      assert %{"id" => id} = json_response(conn, 201)["data"]

      link = Links.get_link!(id)

      assert link.is_starred == @create_attrs.is_starred
      assert link.title == @create_attrs.title
      assert link.url == @create_attrs.url
      assert link.is_starred == @create_attrs.is_starred
      assert link.list_id == list.id
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.link_path(conn, :create), link: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update link" do
    setup [:create_link]

    test "renders link when data is valid", %{conn: conn, link: %Link{id: id} = link} do
      conn = put(conn, Routes.link_path(conn, :update, link), link: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      link = Links.get_link!(id)

      assert link.is_starred == @update_attrs.is_starred
      assert link.title == @update_attrs.title
      assert link.url == @update_attrs.url
      assert link.is_starred == @update_attrs.is_starred
    end

    test "renders errors when data is invalid", %{conn: conn, link: link} do
      conn = put(conn, Routes.link_path(conn, :update, link), link: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete link" do
    setup [:create_link]

    test "deletes chosen link", %{conn: conn, link: link} do
      conn = delete(conn, Routes.link_path(conn, :delete, link))
      assert response(conn, 204)

      refute Links.get_link(link.id)
    end
  end

  defp create_list(_) do
    list = fixture(:list)
    {:ok, list: list}
  end

  defp create_link(_) do
    list = fixture(:list)
    link = fixture(:link, list)
    {:ok, list: list, link: link}
  end
end
