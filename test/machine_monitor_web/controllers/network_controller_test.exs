defmodule MachineMonitorWeb.NetworkControllerTest do
    use MachineMonitorWeb.ConnCase
  
    alias MachineMonitor.{Machine, Accounts, Settings}
    alias MachineMonitor.Settings.Application

    @attrs %{operator: "some serial", type: "some serial"}
  
    setup %{conn: conn} do
      user = create_user()
      conn = sign_in(conn, user)
      %{conn: conn, user: user}
    end

    test "GET / list all networks", %{conn: conn} do
      Settings.create_network(@attrs)
        conn = get(conn, network_path(conn, :index))
        assert json_response(conn, 200)
    end

    test "POST / create new network", %{conn: conn} do
        conn = post(conn, network_path(conn, :add), @attrs)
        assert json_response(conn, 200)
    end

    test "PUT /:id update network", %{conn: conn} do
      {:ok, %{id: id}} = Settings.create_network(@attrs)
      conn = put(conn, network_path(conn, :update, id), @attrs)
      assert json_response(conn, 200)
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