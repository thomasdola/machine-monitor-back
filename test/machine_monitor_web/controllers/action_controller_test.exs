defmodule MachineMonitorWeb.ActionControllerTest do
    use MachineMonitorWeb.ConnCase

    alias MachineMonitor.Accounts

    test "GET / returns all actions", %{conn: conn} do
        # {:ok, %{id: gate_id}} = Accounts.create_gate(%{name: "gate"})
        # {:ok, %{id: entity_id}} = Accounts.create_entity(%{name: "entity", gate_id: gate_id})
        {:ok, _} = Accounts.create_action(%{name: "action"})
        conn = get(conn, action_path(conn, :index))
        assert json_response(conn, 200)
    end

end