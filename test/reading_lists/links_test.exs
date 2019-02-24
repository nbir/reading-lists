defmodule ReadingLists.LinksTest do
  use ReadingLists.DataCase

  alias ReadingLists.ReadingLists.Links
  alias ReadingLists.ReadingLists.Lists

  describe "links" do
    alias ReadingLists.Models.Link

    @valid_attrs %{is_starred: true, title: "some title", url: "some url"}
    @update_attrs %{is_starred: false, title: "some updated title", url: "some updated url"}
    @invalid_attrs %{is_starred: nil, title: nil, url: nil}

    def link_fixture(attrs \\ %{}) do
      {:ok, list} =
        Lists.create_list(%{
          is_starred: false,
          title: "some title"
        })

      {:ok, link} =
        attrs
        |> Enum.into(Map.put(@valid_attrs, :list_id, list.id))
        |> Links.create_link()

      {link, list}
    end

    test "list_links/1 returns all links" do
      {link, list} = link_fixture()
      assert Links.list_links(list.id) == [link]
    end

    test "get_link!/1 returns the link with given id" do
      {link, _} = link_fixture()
      assert Links.get_link!(link.id) == link
    end

    test "get_link/1 returns the link with given id" do
      {link, _} = link_fixture()
      assert Links.get_link(link.id) == link
    end

    test "create_link/1 with valid data creates a link" do
      {_, list} = link_fixture()
      assert {:ok, %Link{} = link} = Links.create_link(Map.put(@valid_attrs, :list_id, list.id))
      assert link.is_starred == true
      assert link.title == "some title"
      assert link.url == "some url"
    end

    test "create_link/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Links.create_link(@invalid_attrs)
    end

    test "update_link/2 with valid data updates the link" do
      {link, _} = link_fixture()
      assert {:ok, %Link{} = link} = Links.update_link(link, @update_attrs)
      assert link.is_starred == false
      assert link.title == "some updated title"
      assert link.url == "some updated url"
    end

    test "update_link/2 with invalid data returns error changeset" do
      {link, _} = link_fixture()
      assert {:error, %Ecto.Changeset{}} = Links.update_link(link, @invalid_attrs)
      assert link == Links.get_link!(link.id)
    end

    test "delete_link/1 deletes the link" do
      {link, _} = link_fixture()
      assert {:ok, %Link{}} = Links.delete_link(link)
      assert_raise Ecto.NoResultsError, fn -> Links.get_link!(link.id) end
    end

    test "change_link/1 returns a link changeset" do
      {link, _} = link_fixture()
      assert %Ecto.Changeset{} = Links.change_link(link)
    end
  end
end
