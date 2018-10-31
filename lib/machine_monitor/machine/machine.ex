defmodule MachineMonitor.Machine do
  @moduledoc """
  The Machine context.
  """

  import Ecto.Query, warn: false
  alias MachineMonitor.Repo

  @default_center_radius 100
  @default_safe_zone [%{longitude: -0.1791814, latitude: 5.6260225}]

  alias MachineMonitor.Machine.Log

  @doc """
  Returns the list of logs.

  ## Examples

      iex> list_logs()
      [%Log{}, ...]

  """
  def list_logs do
    Repo.all(Log)
  end

  @doc """
  Gets a single log.

  Raises `Ecto.NoResultsError` if the Log does not exist.

  ## Examples

      iex> get_log!(123)
      %Log{}

      iex> get_log!(456)
      ** (Ecto.NoResultsError)

  """
  def get_log!(id), do: Repo.get!(Log, id)

  @doc """
  Creates a log.

  ## Examples

      iex> create_log(%{field: value})
      {:ok, %Log{}}

      iex> create_log(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_log(attrs \\ %{}) do
    %Log{}
    |> Log.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a log.

  ## Examples

      iex> update_log(log, %{field: new_value})
      {:ok, %Log{}}

      iex> update_log(log, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_log(%Log{} = log, attrs) do
    log
    |> Log.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Log.

  ## Examples

      iex> delete_log(log)
      {:ok, %Log{}}

      iex> delete_log(log)
      {:error, %Ecto.Changeset{}}

  """
  def delete_log(%Log{} = log) do
    Repo.delete(log)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking log changes.

  ## Examples

      iex> change_log(log)
      %Ecto.Changeset{source: %Log{}}

  """
  def change_log(%Log{} = log) do
    Log.changeset(log, %{})
  end

  alias MachineMonitor.Machine.Monitor

  @doc """
  Returns the list of monitors.

  ## Examples

      iex> list_monitors()
      [%Monitor{}, ...]

  """
  def list_monitors do
    Repo.all(Monitor)
  end

  @doc """
  Gets a single monitor.

  Raises `Ecto.NoResultsError` if the Monitor does not exist.

  ## Examples

      iex> get_monitor!(123)
      %Monitor{}

      iex> get_monitor!(456)
      ** (Ecto.NoResultsError)

  """
  def get_monitor!(id), do: Repo.get!(Monitor, id)

  @doc """
  Creates a monitor.

  ## Examples

      iex> create_monitor(%{field: value})
      {:ok, %Monitor{}}

      iex> create_monitor(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_monitor(attrs \\ %{}) do
    %Monitor{}
    |> Monitor.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a monitor.

  ## Examples

      iex> update_monitor(monitor, %{field: new_value})
      {:ok, %Monitor{}}

      iex> update_monitor(monitor, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_monitor(%Monitor{} = monitor, attrs) do
    monitor
    |> Monitor.changeset(attrs)
    |> Repo.update()
  end

  def update_machine_monitor(machine, update) do
    with %{monitor: %Monitor{} = monitor} <- Repo.preload(machine, [:monitor]),
         {:ok, monitor} <- update_monitor(monitor, update)
    do
        {:ok, machine, monitor}
    else
        %{monitor: nil} -> {:error, :no_monitor}
        error -> error
    end
  end

  @doc """
  Deletes a Monitor.

  ## Examples

      iex> delete_monitor(monitor)
      {:ok, %Monitor{}}

      iex> delete_monitor(monitor)
      {:error, %Ecto.Changeset{}}

  """
  def delete_monitor(%Monitor{} = monitor) do
    Repo.delete(monitor)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking monitor changes.

  ## Examples

      iex> change_monitor(monitor)
      %Ecto.Changeset{source: %Monitor{}}

  """
  def change_monitor(%Monitor{} = monitor) do
    Monitor.changeset(monitor, %{})
  end

  alias MachineMonitor.Machine.Location

  @doc """
  Returns the list of locations.

  ## Examples

      iex> list_locations()
      [%Location{}, ...]

  """
  def list_locations do
    Repo.all(Location)
  end

  @doc """
  Gets a single location.

  Raises `Ecto.NoResultsError` if the Location does not exist.

  ## Examples

      iex> get_location!(123)
      %Location{}

      iex> get_location!(456)
      ** (Ecto.NoResultsError)

  """
  def get_location!(id), do: Repo.get!(Location, id)

  @doc """
  Creates a location.

  ## Examples

      iex> create_location(%{field: value})
      {:ok, %Location{}}

      iex> create_location(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_location(attrs \\ %{}) do
    result = 
        %Location{}
        |> Location.changeset(attrs)
        |> Repo.insert()

    with {:ok, %Location{machine_id: machine_id} = location} <- result,
    %MachineMonitor.Accounts.Machine{} = machine <- MachineMonitor.Accounts.get_machine!(machine_id) do

        case Repo.one(_machine_preload_query(machine)) do
            nil -> {:error, :machine_not_found}
    
            %MachineMonitor.Accounts.Machine{} = machine -> 
                with true <- _out_of_deployment_zone?(machine, location),
                    true <- _out_of_safe_zone?(location)
                do
                    {:ok, Repo.update(location, %{out_of_zone: true})}
                else
                    false -> {:ok, location}
                end
    
            # error -> error
        end
        
    else
        error -> error
    end

  end

  defp _machine_preload_query(%MachineMonitor.Accounts.Machine{id: id}) do
      from m in MachineMonitor.Accounts.Machine,
        where: m.id == ^id,
        preload: [:locations],
        preload: [{:deployments, :center}]
  end

  defp _get_machine_last_or_current_center(%MachineMonitor.Accounts.Machine{deployments: []}), do: nil
  defp _get_machine_last_or_current_center(%MachineMonitor.Accounts.Machine{deployments: deployments}) do
      [%{center: center}|_] = deployments
      center
  end

  defp _out_of_safe_zone?(%{longitude: mac_long, latitude: mac_lat}) do
    Enum.all?(@default_safe_zone, fn %{longitude: long, latitude: lat} ->  
        Distance.GreatCircle.distance({long, lat}, {mac_long, mac_lat}) <= @default_center_radius
    end)
  end

  defp _out_of_deployment_zone?(%MachineMonitor.Accounts.Machine{} = machine, %{longitude: mac_long, latitude: mac_lat}) do
    case _get_machine_last_or_current_center(machine) do
        nil -> true
        %{location: %{longitude: long, latitude: lat}} -> 
            Distance.GreatCircle.distance({long, lat}, {mac_long, mac_lat}) <= @default_center_radius
    end
  end

  @doc """
  Updates a location.

  ## Examples

      iex> update_location(location, %{field: new_value})
      {:ok, %Location{}}

      iex> update_location(location, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_location(%Location{} = location, attrs) do
    location
    |> Location.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Location.

  ## Examples

      iex> delete_location(location)
      {:ok, %Location{}}

      iex> delete_location(location)
      {:error, %Ecto.Changeset{}}

  """
  def delete_location(%Location{} = location) do
    Repo.delete(location)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking location changes.

  ## Examples

      iex> change_location(location)
      %Ecto.Changeset{source: %Location{}}

  """
  def change_location(%Location{} = location) do
    Location.changeset(location, %{})
  end
end
