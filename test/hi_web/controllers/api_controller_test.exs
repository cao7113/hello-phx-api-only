defmodule HiWeb.ApiControllerTest do
  use HiWeb.ConnCase

  test "GET /ping", %{conn: conn} do
    conn = get(conn, ~p"/ping")

    assert %{
             "msg" => "pong"
           } = json_response(conn, 200)
  end
end
