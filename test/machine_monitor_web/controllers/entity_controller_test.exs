defmodule MachineMonitorWeb.EntityControllerTest do
    use MachineMonitorWeb.ConnCase

    alias MachineMonitor.Accounts

    test "GET / returns all entities", %{conn: conn} do
        {:ok, %{id: gate_id}} = Accounts.create_gate(%{name: "gate"})
        {:ok, %{id: entity_id}} = Accounts.create_entity(%{name: "entity", gate_id: gate_id, actions: []})

        conn = get(conn, entity_path(conn, :list))
        assert json_response(conn, 200)

        conn = get(conn, entity_path(conn, :list, %{gate_id: gate_id}))
        assert json_response(conn, 200)
    end

end