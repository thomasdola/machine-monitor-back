defmodule MachineMonitorWeb.GateControllerTest do
    use MachineMonitorWeb.ConnCase

    alias MachineMonitor.Accounts

    test "GET / returns all gates", %{conn: conn} do
        {:ok, %{id: gate_id}} = Accounts.create_gate(%{name: "gate"})
        conn = get(conn, gate_path(conn, :index))
        assert json_response(conn, 200)
    end

end