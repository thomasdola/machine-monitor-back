defmodule MachineMonitorWeb.UserAuthControllerTest do
  use MachineMonitorWeb.ConnCase

  setup %{conn: conn} do
    user = create_user()
    %{conn: conn, user: user}
  end

  test "POST /api/browser/auth/login", %{conn: conn} do
    credentials = %{email: "some@email.com", password: "secrets"}
    conn = post conn, user_auth_path(conn, :login), credentials
    assert %{"token" => _, "full_name" => _, "role" => _} = json_response(conn, 200)
  end

  test "POST /api/browser/auth/logout", %{conn: conn, user: user} do
    conn = sign_in(conn, user)
    conn = post conn, user_auth_path(conn, :logout)
    assert %{"logout" => true} = json_response(conn, 200)
  end

  @user_attrs %{email: "some@email.com", name: "Some Name", password: "secrets"}
  defp create_user do
    {:ok, user} = MachineMonitor.Accounts.create_user(@user_attrs)
    user
  end

  defp sign_in(conn, user) do
    {:ok, token, _} = MachineMonitorWeb.Auth.Guardian.encode_and_sign(user)
    conn |> put_req_header("authorization", "Bearer #{token}")
  end
end
