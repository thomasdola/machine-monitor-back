defmodule MachineMonitorWeb.RoleController do
    use MachineMonitorWeb, :controller

    action_fallback MachineMonitorWeb.ActionFallbackController

    alias MachineMonitor.Accounts
  
    def list(conn, _params) do
      render conn, "list.json", roles: Accounts.list_roles()
    end

end