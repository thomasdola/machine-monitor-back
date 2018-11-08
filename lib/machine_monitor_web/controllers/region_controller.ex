defmodule MachineMonitorWeb.RegionController do
    use MachineMonitorWeb, :controller

    action_fallback MachineMonitorWeb.ActionFallbackController

    alias MachineMonitor.Location
  
    def index(conn, _params) do
      render conn, "index.json", regions: Location.list_regions()
    end

    def add(conn, params) do
        with {:ok, _} <- Location.create_region(params) do
            render conn, "create.json", %{created: true}
        end
    end

    def single(conn, %{"id" => id}) do
        with %Location.Region{} = region <- Location.get_region!(id) do
            render conn, "single.json", %{region: region}
        end 
    end

    def update(conn, %{"id" => id} = params) do
        with %Location.Region{} = region <- Location.get_region!(id), 
            {:ok, _} <- Location.update_region(region, params) do
            render conn, "update.json", %{updated: true}
        end 
    end

    def delete(conn, %{"id" => id}) do
        with %Location.Region{} = region <- Location.get_region!(id), 
            {:ok, _} <- Location.delete_region(region) do
            render conn, "delete.json", %{deleted: true}
        end 
    end
  end
  