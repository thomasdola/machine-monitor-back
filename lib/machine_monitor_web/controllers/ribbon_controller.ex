defmodule MachineMonitorWeb.RibbonController do
    use MachineMonitorWeb, :controller

    action_fallback MachineMonitorWeb.ActionFallbackController

    alias MachineMonitor.Consumables
  
    def index(conn, _params) do
      render conn, "index.json", ribbons: Consumables.list_ribbons()
    end

    def add(conn, %{"date" => date} = params) do
        {timestamp, _} = Integer.parse(date)
        {:ok, datetime} = DateTime.from_unix(timestamp)
        params = %{params | "date" => datetime}
        with {:ok, _} <- Consumables.create_ribbon(params) do
            render conn, "create.json", %{created: true}
        end
    end
  end
  