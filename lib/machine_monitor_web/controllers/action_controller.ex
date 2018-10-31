defmodule MachineMonitorWeb.ActionController do
    use MachineMonitorWeb, :controller

    action_fallback MachineMonitorWeb.ActionFallbackController

    alias MachineMonitor.Accounts
  
    def index(conn, _params) do
      render conn, "index.json", actions: Accounts.list_actions()
    end

end