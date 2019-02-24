defmodule ReadingListsWeb.PageControllerTest do
  use ReadingListsWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Reading Lists"
  end
end
