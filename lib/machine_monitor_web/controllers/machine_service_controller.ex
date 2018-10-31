defmodule MachineMonitorWeb.MachineServiceController do
    use MachineMonitorWeb, :controller

    action_fallback MachineMonitorWeb.ActionFallbackController

    alias MachineMonitor.Settings
  
    def index(conn, _params) do
      render conn, "index.json", services: Settings.list_services()
    end

    def add(conn, params) do
        with {:ok, _} <- Settings.create_service(params) do
            render conn, "create.json", %{created: true}
        end
    end

    def single(conn, %{"id" => id}) do
        with %Settings.Service{} = service <- Settings.get_service!(id) do
            render conn, "single.json", %{service: service}
        end 
    end

    def update(conn, %{"id" => id} = params) do
        with %Settings.Service{} = service <- Settings.get_service!(id), 
            {:ok, _} <- Settings.update_service(service, params) do
            render conn, "update.json", %{updated: true}
        end 
    end

    def delete(conn, %{"id" => id}) do
        with %Settings.Service{} = service <- Settings.get_service!(id), 
            {:ok, _} <- Settings.delete_service(service) do
            render conn, "delete.json", %{deleted: true}
        end 
    end
  end
  