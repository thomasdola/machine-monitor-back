defmodule MachineMonitorWeb.MachineApplicationController do
    use MachineMonitorWeb, :controller

    action_fallback MachineMonitorWeb.ActionFallbackController

    alias MachineMonitor.Settings
  
    def index(conn, _params) do
      render conn, "index.json", applications: Settings.list_applications()
    end

    def add(conn, params) do
        with {:ok, _} <- Settings.create_application(params) do
            render conn, "create.json", %{created: true}
        end
    end

    def single(conn, %{"id" => id}) do
        with %Settings.Application{} = application <- Settings.get_application!(id) do
            render conn, "single.json", %{application: application}
        end 
    end

    def update(conn, %{"id" => id} = params) do
        with %Settings.Application{} = application <- Settings.get_application!(id), 
            {:ok, _} <- Settings.update_application(application, params) do
            render conn, "update.json", %{updated: true}
        end 
    end

    def delete(conn, %{"id" => id}) do
        with %Settings.Application{} = application <- Settings.get_application!(id), 
            {:ok, _} <- Settings.delete_application(application) do
            render conn, "delete.json", %{deleted: true}
        end 
    end
  end
  