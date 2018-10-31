defmodule MachineMonitorWeb.NetworkController do
    use MachineMonitorWeb, :controller

    action_fallback MachineMonitorWeb.ActionFallbackController

    alias MachineMonitor.Settings
  
    def index(conn, _params) do
      render conn, "index.json", networks: Settings.list_networks()
    end

    def add(conn, params) do
        with {:ok, _} <- Settings.create_network(params) do
            render conn, "create.json", %{created: true}
        end
    end

    def single(conn, %{"id" => id}) do
        with %Settings.Network{} = network <- Settings.get_network!(id) do
            render conn, "single.json", %{network: network}
        end 
    end

    def update(conn, %{"id" => id} = params) do
        with %Settings.Network{} = network <- Settings.get_network!(id), 
            {:ok, _} <- Settings.update_network(network, params) do
            render conn, "update.json", %{updated: true}
        end 
    end

    def delete(conn, %{"id" => id}) do
        with %Settings.Network{} = network <- Settings.get_network!(id), 
            {:ok, _} <- Settings.delete_network(network) do
            render conn, "delete.json", %{deleted: true}
        end 
    end
  end
  