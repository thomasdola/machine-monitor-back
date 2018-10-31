defmodule MachineMonitorWeb.MachineAuthControllerTest do
  use MachineMonitorWeb.ConnCase

  setup %{conn: conn} do
    machine = create_user()
    %{conn: conn, machine: machine}
  end

  test "POST /api/windows/auth/login", %{conn: conn} do
    credentials = %{name: "Machine", password: "465487985464654"}
    conn = post conn, machine_auth_path(conn, :login), credentials
    assert %{"jwt" => %{"token" => _}, "uuid" => uuid} = json_response(conn, 200)
    refute is_nil(uuid)
  end

  test "POST /api/windows/auth/register", %{conn: conn} do
    data = %{name: "Machine", password: "465487985464654"}
    conn = post conn, machine_auth_path(conn, :register), data
    assert %{"jwt" => %{"token" => _}, "uuid" => uuid} = json_response(conn, 200)
    refute is_nil(uuid)
  end

  test "POST /api/windows/auth/logout", %{conn: conn, machine: machine} do
    conn = sign_in(conn, machine)
    conn = post conn, machine_auth_path(conn, :logout)
    assert %{"logout" => true} = json_response(conn, 200)
  end

  @machine_attrs %{name: "Machine", password: "465487985464654"}
  defp create_user do
    {:ok, machine} = MachineMonitor.Accounts.create_machine(@machine_attrs)
    machine
  end

  defp sign_in(conn, machine) do
    {:ok, token, _} = MachineMonitorWeb.Auth.Guardian.encode_and_sign(machine)
    conn |> put_req_header("authorization", "Bearer #{token}")
  end
end
