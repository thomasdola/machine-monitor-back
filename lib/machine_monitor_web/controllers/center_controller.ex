defmodule MachineMonitorWeb.CenterController do
    use MachineMonitorWeb, :controller

    action_fallback MachineMonitorWeb.ActionFallbackController

    alias MachineMonitor.Settings
    alias MachineMonitorWeb.Serializers.Center, as: CenterSerializer

    @sketches_folder "/store/sketches"
    @seeds_folder "/store/seeds"

    def list(conn, _params) do
        centers = center = CenterSerializer.to_map(Settings.list_centers(:preload))
        render conn, "list.json", centers: centers, pagination: %{}
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

    def update(conn, %{"id" => id, "sketch" => %Plug.Upload{path: temp_path}} = params) do
        {:ok, sketch_new_path, _} = Settings.copy_images(temp_path, @sketches_folder)
        params = %{params | "sketch" => sketch_new_path}
        data = _prepare_data(params)
        with %Settings.Center{} = center <- Settings.get_center!(id),
            {:ok, _} <- Settings.update_center(center, data) do
                render conn, "update.json", %{updated: true}
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

    defp _extract_location(%{"ghana_post_gps" => gps, "longitude" => long, "latitude" => lat, "sketch" => sketch}) do
        %{
            ghana_post_gps: gps,
            longitude: long,
            latitude: lat,
            sketch: sketch
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