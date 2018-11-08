defmodule MachineMonitorWeb.MachineLogControllerTest do
  use MachineMonitorWeb.ConnCase

  alias MachineMonitor.{Machine, Accounts, Settings}

  setup %{conn: conn} do
    user = create_user()
    conn = sign_in(conn, user)
    %{conn: conn, user: user, machine: machine_fixture()}
  end

  test "GET / returns machine logs", %{conn: conn, user: user, machine: %{name: name}} do
    conn = get(conn, machine_log_path(conn, :list, name), %{p: 1, pp: 20})
    assert json_response(conn, 200)
  end

  @machine_attrs %{name: "MRW 0021", password: "fjalkdjfakdjfl", manucfacturing_id: "6546579846546546548"}
  defp machine_fixture() do
    {:ok, %Accounts.Machine{} = machine} = Accounts.create_machine(@machine_attrs)
    machine
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