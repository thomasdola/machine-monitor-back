defmodule MachineMonitorWeb.PrinterControllerTest do
    use MachineMonitorWeb.ConnCase
  
    alias MachineMonitor.{Machine, Accounts, Settings}
    alias MachineMonitor.Settings.Application

    @attrs %{serial: "some serial", laminator: "some serial"}
  
    setup %{conn: conn} do
      user = create_user()
      conn = sign_in(conn, user)
      %{conn: conn, user: user}
    end

    test "GET / list all printers", %{conn: conn} do
      Settings.create_printer(@attrs)
        conn = get(conn, printer_path(conn, :index))
        assert json_response(conn, 200)
    end

    test "POST / create new printer", %{conn: conn} do
        conn = post(conn, printer_path(conn, :add), @attrs)
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