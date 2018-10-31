defmodule MachineMonitorWeb.LaminateController do
    use MachineMonitorWeb, :controller

    action_fallback MachineMonitorWeb.ActionFallbackController

    alias MachineMonitor.Consumables
  
    def index(conn, _params) do
      render conn, "index.json", laminates: Consumables.list_laminates()
    end

    def add(conn, %{"date" => date} = params) do
        {timestamp, _} = Integer.parse(date)
        {:ok, datetime} = DateTime.from_unix(timestamp)
        params = %{params | "date" => datetime}
        with {:ok, _} <- Consumables.create_laminate(params) do
            render conn, "create.json", %{created: true}
        end
    end
  end
  