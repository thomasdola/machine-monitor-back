defmodule MachineMonitorWeb.PrinterController do
    use MachineMonitorWeb, :controller

    action_fallback MachineMonitorWeb.ActionFallbackController

    alias MachineMonitor.Settings
  
    def index(conn, _params) do
      render conn, "index.json", printers: Settings.list_printers()
    end

    def add(conn, params) do
        with {:ok, _} <- Settings.create_printer(params) do
            render conn, "create.json", %{created: true}
        end
    end

    def single(conn, %{"id" => id}) do
        with %Settings.Printer{} = printer <- Settings.get_printer!(id) do
            render conn, "single.json", %{printer: printer}
        end 
    end

    def update(conn, %{"id" => id} = params) do
        with %Settings.Printer{} = printer <- Settings.get_printer!(id), 
            {:ok, _} <- Settings.update_printer(printer, params) do
            render conn, "update.json", %{updated: true}
        end 
    end

    def delete(conn, %{"id" => id}) do
        with %Settings.Printer{} = printer <- Settings.get_printer!(id), 
            {:ok, _} <- Settings.delete_printer(printer) do
            render conn, "delete.json", %{deleted: true}
        end 
    end
  end
  