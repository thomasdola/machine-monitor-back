defmodule MachineMonitorWeb.DistrictController do
    use MachineMonitorWeb, :controller

    action_fallback MachineMonitorWeb.ActionFallbackController

    alias MachineMonitor.Location
  
    def list(conn, params) do
      render conn, "index.json", districts: Location.list_district(params)
    end

    def add(conn, params) do
        with {:ok, _} <- Location.create_district(params) do
            render conn, "create.json", %{created: true}
        end
    end

    def single(conn, %{"id" => id}) do
        with %Location.District{} = district <- Location.get_district!(id) do
            render conn, "single.json", %{district: district}
        end 
    end

    def update(conn, %{"id" => id} = params) do
        with %Location.District{} = district <- Location.get_district!(id), 
            {:ok, _} <- Location.update_district(district, params) do
            render conn, "update.json", %{updated: true}
        end 
    end

    def delete(conn, %{"id" => id}) do
        with %Location.District{} = district <- Location.get_district!(id), 
            {:ok, _} <- Location.delete_district(district) do
            render conn, "delete.json", %{deleted: true}
        end 
    end
  end
  