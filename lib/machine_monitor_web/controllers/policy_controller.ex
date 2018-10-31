defmodule MachineMonitorWeb.PolicyController do
    use MachineMonitorWeb, :controller

    action_fallback MachineMonitorWeb.ActionFallbackController

    alias MachineMonitor.Accounts
  
    def list(conn, _params) do
      render conn, "list.json", policies: Accounts.list_policies()
    end

end