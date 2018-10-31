defmodule MachineMonitorWeb.EntityController do
    use MachineMonitorWeb, :controller

    action_fallback MachineMonitorWeb.ActionFallbackController

    alias MachineMonitor.Accounts
  
    def list(conn, %{"gate" => gate_id}) do
      render conn, "index.json", entities: Accounts.list_entities(gate_id)
    end
    def list(conn, _params) do
      render conn, "index.json", entities: Accounts.list_entities()
    end

end