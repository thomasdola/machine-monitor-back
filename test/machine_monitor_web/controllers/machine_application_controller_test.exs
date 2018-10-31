defmodule MachineMonitorWeb.MachineApplicationControllerTest do
    use MachineMonitorWeb.ConnCase
  
    alias MachineMonitor.{Machine, Accounts, Settings}
    alias MachineMonitor.Settings.Application

    @attrs %{name: "some name", display: "some display name", path: "some path"}
  
    setup %{conn: conn} do
      user = create_user()
      conn = sign_in(conn, user)
      %{conn: conn, user: user}
    end

    test "GET / list all applications", %{conn: conn} do
        Settings.create_application(@attrs)
        conn = get(conn, machine_application_path(conn, :index))
        assert json_response(conn, 200)
    end

    test "POST / create new application", %{conn: conn} do
        conn = post(conn, machine_application_path(conn, :add), @attrs)
        assert json_response(conn, 200)
    end

    test "PUT /:id update application", %{conn: conn} do
        {:ok, %{id: id}} = Settings.create_application(@attrs)
        conn = put(conn, machine_application_path(conn, :update, id), @attrs)
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