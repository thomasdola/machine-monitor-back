defmodule MachineMonitorWeb.GateController do
    use MachineMonitorWeb, :controller

    action_fallback MachineMonitorWeb.ActionFallbackController

    alias MachineMonitor.Accounts
  
    def index(conn, _params) do
      render conn, "index.json", gates: Accounts.list_gates()
    end

end