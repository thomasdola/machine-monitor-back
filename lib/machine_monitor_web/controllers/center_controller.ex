defmodule MachineMonitorWeb.CenterController do
    use MachineMonitorWeb, :controller

    action_fallback MachineMonitorWeb.ActionFallbackController

    alias MachineMonitor.Settings
    alias MachineMonitorWeb.Serializers.Center, as: CenterSerializer
    alias MachineMonitorWeb.Serializers.Center.Map, as: MapCenterSerializer

    @sketches_folder "/store/sketches"
    @seeds_folder "/store/seeds"

    def list(conn, %{"map" => _} = params) do
        %{centers: centers, pagination: pagination} = Settings.list_centers(params)
        centers = MapCenterSerializer.to_map(centers) |> Enum.reject(fn c-> is_nil(c.longitude) || is_nil(c.latitude) end)
        render conn, "map.json", centers: centers, pagination: pagination
    end
    def list(conn, params) do
        %{centers: centers, pagination: pagination} = Settings.list_centers(params)
        render conn, "list.json", centers: centers, pagination: pagination
    end

    def add(conn, %{"sheet" => %Plug.Upload{path: temp_path}}) do
        {:ok, _, new_path} = Settings.copy_images(temp_path, @seeds_folder)
        IO.inspect {:centers_sheet, new_path}
        with :ok <- Settings.create_centers_from_sheet(new_path) do
            File.rm!(new_path)
            render conn, "create.json", %{created: true}
        end
    end
    def add(conn, params) do
        with {:ok, _} <- Settings.create_center(params) do
            render conn, "create.json", %{created: true}
        end
    end

    def single(conn, %{"id" => id}) do
        with %Settings.Center{} = center <- Settings.get_center(id) do
            center = CenterSerializer.to_map(center)
            IO.inspect {:single, center}
            render conn, "single.json", %{center: center}
        end
    end

    def update(conn, %{"id" => id, "deployment" => _} = params) do
        data = _prepare_deployment_data(params)
        IO.inspect {:deployment, data}
        with %Settings.Center{} = center <- Settings.get_center!(id),
            {:ok, _} <- Settings.create_deployment(data), 
            {:ok, %{}} <- Settings.update_center(center, %{status: 1}) do
                render conn, "update.json", %{updated: true}
        end
    end
    def update(conn, %{"id" => id} = params) do
        sketch = Map.get(params, "sketch")
        params = case sketch do
            %Plug.Upload{path: temp_path, filename: temp_filename} ->
                {:ok, sketch_new_path, _} = Settings.copy_images(temp_path, @sketches_folder, temp_filename)
                %{params | "sketch" => sketch_new_path}
            _ -> params
        end

        data = _prepare_data(params)
        with %Settings.Center{} = center <- Settings.get_center!(id),
            {:ok, _} <- Settings.update_center(center, data) do
                render conn, "update.json", %{updated: true}
        end
    end

    def delete(conn, %{"id" => id}) do
        with %Settings.Center{} = center <- Settings.get_center!(id),
            {:ok, _} <- Settings.delete_center(center) do
                render conn, "delete.json", %{deleted: true}     
        end
    end

    defp _prepare_data(%{"name" => name, "code" => code} = params) do
        location = _extract_location(params)
        contact = _extract_contact(params)
        recomendation = _extract_recomendation(params)

        %{
            name: name,
            code: code,
            location: location,
            contact: contact,
            recomendation: recomendation
        }
    end

    defp _extract_location(%{"sketch" => sketch} = params) do
        %{
            ghana_post_gps: Map.get(params, "ghana_post_gps"),
            longitude: Map.get(params, "longitude"),
            latitude: Map.get(params, "latitude"),
            region_id: Map.get(params, "region_id"),
            district_id: Map.get(params, "district_id"),
            sketch: sketch
        }
    end
    defp _extract_location(params) do
        %{
            ghana_post_gps: Map.get(params, "ghana_post_gps"),
            longitude: Map.get(params, "longitude"),
            latitude: Map.get(params, "latitude"),
            region_id: Map.get(params, "region_id"),
            district_id: Map.get(params, "district_id"),
        }
    end

    defp _extract_contact(%{"contact_name" => name, "contact_phone" => phone}) do
        %{
            name: name,
            phone: phone
        }
    end

    defp _extract_recomendation(%{"preferred_network" => p_n, "backup_network" => b_n, "recomended" => r}) do
        %{
            preferred_network: p_n,
            backup_network: b_n,
            recomended: r
        }
    end

    defp _prepare_deployment_data(%{"start_date" => start_date, "end_date" => end_date} = params) do
        {:ok, start_date} = DateTime.from_unix(String.to_integer(start_date))
        {:ok, end_date} = DateTime.from_unix(String.to_integer(end_date))
        %{
            params | "start_date" => start_date, "end_date" => end_date
        }
    end

end