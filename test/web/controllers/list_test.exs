defmodule ReadingListsWeb.ListControllerTest do
  use ReadingListsWeb.ConnCase

  alias Ecto.UUID

  alias ReadingLists.Models.List
  alias ReadingLists.ReadingLists.Lists

  @create_attrs %{
    is_starred: false,
    title: "some title"
  }
  @update_attrs %{
    is_starred: true,
    title: "some updated title"
  }
  @invalid_attrs %{is_starred: nil, title: nil}

  def fixture(:list) do
    {:ok, list} = Lists.create_list(@create_attrs)
    list
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    setup [:create_list]

    test "lists all lists", %{conn: conn, list: list} do
      conn = get(conn, Routes.list_path(conn, :index))

      assert json_response(conn, 200)["data"] == [
               %{
                 "id" => list.id,
                 "title" => list.title,
                 "is_starred" => list.is_starred,
                 "inserted_at" => DateTime.to_iso8601(list.inserted_at),
                 "updated_at" => DateTime.to_iso8601(list.updated_at)
               }
             ]
    end
  end

  describe "show list" do
    setup [:create_list]

    test "renders list when data is valid", %{conn: conn, list: list} do
      conn = get(conn, Routes.list_path(conn, :show, list.id))

      assert %{
               "id" => id,
               "is_starred" => false,
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = get(conn, Routes.list_path(conn, :show, UUID.generate()))
      assert response(conn, 404)
    end
  end

  describe "create list" do
    test "renders list when data is valid", %{conn: conn} do
      conn = post(conn, Routes.list_path(conn, :create), list: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      list = Lists.get_list!(id)

      assert list.is_starred == @create_attrs.is_starred
      assert list.title == @create_attrs.title
      assert list.is_starred == @create_attrs.is_starred
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.list_path(conn, :create), list: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update list" do
    setup [:create_list]

    test "renders list when data is valid", %{conn: conn, list: %List{id: id} = list} do
      conn = put(conn, Routes.list_path(conn, :update, list), list: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      list = Lists.get_list!(id)

      assert list.is_starred == @update_attrs.is_starred
      assert list.title == @update_attrs.title
      assert list.is_starred == @update_attrs.is_starred
    end

    test "renders errors when data is invalid", %{conn: conn, list: list} do
      conn = put(conn, Routes.list_path(conn, :update, list), list: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete list" do
    setup [:create_list]

    test "deletes chosen list", %{conn: conn, list: list} do
      conn = delete(conn, Routes.list_path(conn, :delete, list))
      assert response(conn, 204)

      refute Lists.get_list(list.id)
    end
  end

  defp create_list(_) do
    list = fixture(:list)
    {:ok, list: list}
  end
end
