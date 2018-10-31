defmodule MachineMonitor.Settings do
  @moduledoc """
  The Settings context.
  """

  import Ecto.Query, warn: false
  alias MachineMonitor.Repo

  @sketches_folder "/store/sketches"
  @priv_folder :code.priv_dir(:machine_monitor)

  alias MachineMonitor.Settings.Application

  @doc """
  Returns the list of applications.

  ## Examples

      iex> list_applications()
      [%Application{}, ...]

  """
  def list_applications do
    Repo.all(Application)
  end

  @doc """
  Gets a single application.

  Raises `Ecto.NoResultsError` if the Application does not exist.

  ## Examples

      iex> get_application!(123)
      %Application{}

      iex> get_application!(456)
      ** (Ecto.NoResultsError)

  """
  def get_application!(id), do: Repo.get!(Application, id)
  def get_application_by_name(name), do: Repo.get_by(Application, name: name)

  @doc """
  Creates a application.

  ## Examples

      iex> create_application(%{field: value})
      {:ok, %Application{}}

      iex> create_application(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_application(attrs \\ %{}) do
    %Application{}
    |> Application.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a application.

  ## Examples

      iex> update_application(application, %{field: new_value})
      {:ok, %Application{}}

      iex> update_application(application, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_application(%Application{} = application, attrs) do
    application
    |> Application.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Application.

  ## Examples

      iex> delete_application(application)
      {:ok, %Application{}}

      iex> delete_application(application)
      {:error, %Ecto.Changeset{}}

  """
  def delete_application(%Application{} = application) do
    Repo.delete(application)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking application changes.

  ## Examples

      iex> change_application(application)
      %Ecto.Changeset{source: %Application{}}

  """
  def change_application(%Application{} = application) do
    Application.changeset(application, %{})
  end

  alias MachineMonitor.Settings.Service

  @doc """
  Returns the list of services.

  ## Examples

      iex> list_services()
      [%Service{}, ...]

  """
  def list_services do
    Repo.all(Service)
  end

  @doc """
  Gets a single service.

  Raises `Ecto.NoResultsError` if the Service does not exist.

  ## Examples

      iex> get_service!(123)
      %Service{}

      iex> get_service!(456)
      ** (Ecto.NoResultsError)

  """
  def get_service!(id), do: Repo.get!(Service, id)
  def get_service_by_name(name), do: Repo.get_by(Service, name: name)

  @doc """
  Creates a service.

  ## Examples

      iex> create_service(%{field: value})
      {:ok, %Service{}}

      iex> create_service(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_service(attrs \\ %{}) do
    %Service{}
    |> Service.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a service.

  ## Examples

      iex> update_service(service, %{field: new_value})
      {:ok, %Service{}}

      iex> update_service(service, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_service(%Service{} = service, attrs) do
    service
    |> Service.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Service.

  ## Examples

      iex> delete_service(service)
      {:ok, %Service{}}

      iex> delete_service(service)
      {:error, %Ecto.Changeset{}}

  """
  def delete_service(%Service{} = service) do
    Repo.delete(service)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking service changes.

  ## Examples

      iex> change_service(service)
      %Ecto.Changeset{source: %Service{}}

  """
  def change_service(%Service{} = service) do
    Service.changeset(service, %{})
  end

  alias MachineMonitor.Settings.Center

  @doc """
  Returns the list of centers.

  ## Examples

      iex> list_centers()
      [%Center{}, ...]

  """
  def list_centers do
    Repo.all(Center)
  end
  def list_centers(:preload) do
    query = from c in Center,
        preload: [{:deployments, :printers}],
        preload: [deployments: [machines: ^_machines_query()]]

    Repo.all(query)
  end

  defp _locations_query() do
    from l in MachineMonitor.Machine.Location, order_by: [asc: :inserted_at]
  end
  defp _machines_query() do
    from m in MachineMonitor.Accounts.Machine,
        preload: [:monitor, locations: ^_locations_query()]
  end

  @doc """
  Gets a single center.

  Raises `Ecto.NoResultsError` if the Center does not exist.

  ## Examples

      iex> get_center!(123)
      %Center{}

      iex> get_center!(456)
      ** (Ecto.NoResultsError)

  """
  def get_center!(id), do: Repo.get!(Center, id)
  def get_center(id) do
      query = from c in Center, 
        where: c.id == ^id,
        preload: [{:deployments, :printers}],
        preload: [deployments: [machines: ^_machines_query()]]

    Repo.one(query)
  end

  @doc """
  Creates a center.

  ## Examples

      iex> create_center(%{field: value})
      {:ok, %Center{}}

      iex> create_center(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_center(attrs \\ %{}) do
    %Center{}
    |> Center.changeset(attrs)
    |> Repo.insert()
  end

  def create_centers_from_sheet(sheet) do
    # [_ | [data]] = CSVLixir.read(sheet) |> Enum.to_list()

    [{:ok, table_id}] = Xlsxir.multi_extract(sheet)
    [_header | data ] = Xlsxir.get_list(table_id)

    # IO.inspect {:sheet, data, List.to_tuple(data)}

    centers = Enum.reject(data, fn [code|_] -> 
        is_nil(code)
    end) 
    |> Enum.map(fn [code|[name |[coordinates |[address]]]] ->
        [lat|[lon]] = String.split(coordinates, ",")
        %{name: name, code: code, location: %{ghana_post_gps: address, longitude: lon, latitude: lat}}
    end)

    # IO.inspect {:centers_sheet, centers}

    Enum.each(centers, &create_center/1)

    :ok
  end

  @doc """
  Updates a center.

  ## Examples

      iex> update_center(center, %{field: new_value})
      {:ok, %Center{}}

      iex> update_center(center, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_center(%Center{} = center, attrs) do
    center
    |> Center.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Center.

  ## Examples

      iex> delete_center(center)
      {:ok, %Center{}}

      iex> delete_center(center)
      {:error, %Ecto.Changeset{}}

  """
  def delete_center(%Center{} = center) do
    Repo.delete(center)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking center changes.

  ## Examples

      iex> change_center(center)
      %Ecto.Changeset{source: %Center{}}

  """
  def change_center(%Center{} = center) do
    Center.changeset(center, %{})
  end

  alias MachineMonitor.Settings.Deployment

  @doc """
  Returns the list of deployments.

  ## Examples

      iex> list_deployments()
      [%Deployment{}, ...]

  """
  def list_deployments do
    Repo.all(Deployment)
  end

  @doc """
  Gets a single deployment.

  Raises `Ecto.NoResultsError` if the Deployment does not exist.

  ## Examples

      iex> get_deployment!(123)
      %Deployment{}

      iex> get_deployment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_deployment!(id), do: Repo.get!(Deployment, id)

  @doc """
  Creates a deployment.

  ## Examples

      iex> create_deployment(%{field: value})
      {:ok, %Deployment{}}

      iex> create_deployment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_deployment(attrs \\ %{}) do
    result = %Deployment{}
    |> Deployment.changeset(attrs)
    |> Repo.insert()

    if Map.get(attrs, "deployment") do
        case result do
            {:ok, deployment} ->
                printers = Enum.map(Map.get(attrs, "printers"), fn printer_id -> get_printer!(printer_id) end)
                machines = Enum.map(Map.get(attrs, "machines"), fn machine_id -> MachineMonitor.Accounts.get_machine!(machine_id) end)
    
                deployment = Repo.preload(deployment, [:printers, :machines])
                |> Ecto.Changeset.change()
                |> Ecto.Changeset.put_assoc(:printers, printers)
                |> Ecto.Changeset.put_assoc(:machines, machines)
                |> Repo.update!()

                {:ok, deployment}
    
            error -> error
        end
    else
        result
    end
  end

  @doc """
  Updates a deployment.

  ## Examples

      iex> update_deployment(deployment, %{field: new_value})
      {:ok, %Deployment{}}

      iex> update_deployment(deployment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_deployment(%Deployment{} = deployment, attrs) do
    deployment
    |> Deployment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Deployment.

  ## Examples

      iex> delete_deployment(deployment)
      {:ok, %Deployment{}}

      iex> delete_deployment(deployment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_deployment(%Deployment{} = deployment) do
    Repo.delete(deployment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking deployment changes.

  ## Examples

      iex> change_deployment(deployment)
      %Ecto.Changeset{source: %Deployment{}}

  """
  def change_deployment(%Deployment{} = deployment) do
    Deployment.changeset(deployment, %{})
  end

  alias MachineMonitor.Settings.Network

  @doc """
  Returns the list of networks.

  ## Examples

      iex> list_networks()
      [%Network{}, ...]

  """
  def list_networks do
    Repo.all(Network)
  end

  @doc """
  Gets a single network.

  Raises `Ecto.NoResultsError` if the Network does not exist.

  ## Examples

      iex> get_network!(123)
      %Network{}

      iex> get_network!(456)
      ** (Ecto.NoResultsError)

  """
  def get_network!(id), do: Repo.get!(Network, id)

  @doc """
  Creates a network.

  ## Examples

      iex> create_network(%{field: value})
      {:ok, %Network{}}

      iex> create_network(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_network(attrs \\ %{}) do
    %Network{}
    |> Network.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a network.

  ## Examples

      iex> update_network(network, %{field: new_value})
      {:ok, %Network{}}

      iex> update_network(network, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_network(%Network{} = network, attrs) do
    network
    |> Network.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Network.

  ## Examples

      iex> delete_network(network)
      {:ok, %Network{}}

      iex> delete_network(network)
      {:error, %Ecto.Changeset{}}

  """
  def delete_network(%Network{} = network) do
    Repo.delete(network)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking network changes.

  ## Examples

      iex> change_network(network)
      %Ecto.Changeset{source: %Network{}}

  """
  def change_network(%Network{} = network) do
    Network.changeset(network, %{})
  end

  alias MachineMonitor.Settings.Printer

  @doc """
  Returns the list of printers.

  ## Examples

      iex> list_printers()
      [%Printer{}, ...]

  """
  def list_printers do
    Repo.all(Printer)
  end

  @doc """
  Gets a single printer.

  Raises `Ecto.NoResultsError` if the Printer does not exist.

  ## Examples

      iex> get_printer!(123)
      %Printer{}

      iex> get_printer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_printer!(id), do: Repo.get!(Printer, id)

  @doc """
  Creates a printer.

  ## Examples

      iex> create_printer(%{field: value})
      {:ok, %Printer{}}

      iex> create_printer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_printer(attrs \\ %{}) do
    %Printer{}
    |> Printer.changeset(attrs)
    |> Repo.insert()
  end

  def create_printers(sheet) do
    [{:ok, table_id}] = Xlsxir.multi_extract(sheet)
    [_ | printers] = Xlsxir.get_list(table_id)
  end

  @doc """
  Updates a printer.

  ## Examples

      iex> update_printer(printer, %{field: new_value})
      {:ok, %Printer{}}

      iex> update_printer(printer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_printer(%Printer{} = printer, attrs) do
    printer
    |> Printer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Printer.

  ## Examples

      iex> delete_printer(printer)
      {:ok, %Printer{}}

      iex> delete_printer(printer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_printer(%Printer{} = printer) do
    Repo.delete(printer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking printer changes.

  ## Examples

      iex> change_printer(printer)
      %Ecto.Changeset{source: %Printer{}}

  """
  def change_printer(%Printer{} = printer) do
    Printer.changeset(printer, %{})
  end

  def copy_images(path, folder) do
    ext = Path.extname(path)
    file_name = Nanoid.generate() <> ext
    new_file_path = folder <> "/" <> file_name
    new_path = Path.join("#{@priv_folder}", "#{new_file_path}")
    IO.inspect {:copy_file, File.exists?(path), new_file_path, new_path}
    File.cp!(path, new_path)
    {:ok, new_file_path, new_path}
  end
end
