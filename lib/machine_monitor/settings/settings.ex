defmodule MachineMonitor.Settings do
  @moduledoc """
  The Settings context.
  """

  import Ecto.Query, warn: false
  alias MachineMonitor.Repo

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
end
