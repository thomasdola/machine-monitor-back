defmodule MachineMonitor.SettingsTest do
  use MachineMonitor.DataCase

  alias MachineMonitor.Settings

  describe "applications" do
    alias MachineMonitor.Settings.Application

    @valid_attrs %{name: "some name", path: "some path", display: "Some Name"}
    @update_attrs %{name: "some updated name", path: "some updated path"}
    @invalid_attrs %{name: nil, path: nil, display: nil}

    def application_fixture(attrs \\ %{}) do
      {:ok, application} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_application()

      application
    end

    test "list_applications/0 returns all applications" do
      application = application_fixture()
      assert Settings.list_applications() == [application]
    end

    test "get_application!/1 returns the application with given id" do
      application = application_fixture()
      assert Settings.get_application!(application.id) == application
    end

    test "create_application/1 with valid data creates a application" do
      assert {:ok, %Application{} = application} = Settings.create_application(@valid_attrs)
      assert application.name == "some name"
      assert application.path == "some path"
    end

    test "create_application/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_application(@invalid_attrs)
    end

    test "update_application/2 with valid data updates the application" do
      application = application_fixture()
      assert {:ok, application} = Settings.update_application(application, @update_attrs)
      assert %Application{} = application
      assert application.name == "some updated name"
      assert application.path == "some updated path"
    end

    test "update_application/2 with invalid data returns error changeset" do
      application = application_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_application(application, @invalid_attrs)
      assert application == Settings.get_application!(application.id)
    end

    test "delete_application/1 deletes the application" do
      application = application_fixture()
      assert {:ok, %Application{}} = Settings.delete_application(application)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_application!(application.id) end
    end

    test "change_application/1 returns a application changeset" do
      application = application_fixture()
      assert %Ecto.Changeset{} = Settings.change_application(application)
    end
  end

  describe "services" do
    alias MachineMonitor.Settings.Service

    @valid_attrs %{name: "some name", path: "some path", display: "Some Display Name"}
    @update_attrs %{name: "some updated name", path: "some updated path"}
    @invalid_attrs %{name: nil, path: nil, display: nil}

    def service_fixture(attrs \\ %{}) do
      {:ok, service} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_service()

      service
    end

    test "list_services/0 returns all services" do
      service = service_fixture()
      assert Settings.list_services() == [service]
    end

    test "get_service!/1 returns the service with given id" do
      service = service_fixture()
      assert Settings.get_service!(service.id) == service
    end

    test "create_service/1 with valid data creates a service" do
      assert {:ok, %Service{} = service} = Settings.create_service(@valid_attrs)
      assert service.name == "some name"
      assert service.path == "some path"
    end

    test "create_service/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_service(@invalid_attrs)
    end

    test "update_service/2 with valid data updates the service" do
      service = service_fixture()
      assert {:ok, service} = Settings.update_service(service, @update_attrs)
      assert %Service{} = service
      assert service.name == "some updated name"
      assert service.path == "some updated path"
    end

    test "update_service/2 with invalid data returns error changeset" do
      service = service_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_service(service, @invalid_attrs)
      assert service == Settings.get_service!(service.id)
    end

    test "delete_service/1 deletes the service" do
      service = service_fixture()
      assert {:ok, %Service{}} = Settings.delete_service(service)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_service!(service.id) end
    end

    test "change_service/1 returns a service changeset" do
      service = service_fixture()
      assert %Ecto.Changeset{} = Settings.change_service(service)
    end
  end

  describe "centers" do
    alias MachineMonitor.Settings.Center

    @valid_attrs %{code: "some code", name: "some name"}
    @update_attrs %{code: "some updated code", name: "some updated name"}
    @invalid_attrs %{code: nil, name: nil}

    def center_fixture(attrs \\ %{}) do
      {:ok, center} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_center()

      center
    end

    test "list_centers/0 returns all centers" do
      center = center_fixture()
      assert Settings.list_centers() == [center]
    end

    test "get_center!/1 returns the center with given id" do
      center = center_fixture()
      assert Settings.get_center!(center.id) == center
    end

    test "create_center/1 with valid data creates a center" do
      assert {:ok, %Center{} = center} = Settings.create_center(@valid_attrs)
      assert center.code == "some code"
      assert center.name == "some name"
    end

    test "create_center/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_center(@invalid_attrs)
    end

    test "update_center/2 with valid data updates the center" do
      center = center_fixture()
      assert {:ok, center} = Settings.update_center(center, @update_attrs)
      assert %Center{} = center
      assert center.code == "some updated code"
      assert center.name == "some updated name"
    end

    test "update_center/2 with invalid data returns error changeset" do
      center = center_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_center(center, @invalid_attrs)
      assert center == Settings.get_center!(center.id)
    end

    test "delete_center/1 deletes the center" do
      center = center_fixture()
      assert {:ok, %Center{}} = Settings.delete_center(center)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_center!(center.id) end
    end

    test "change_center/1 returns a center changeset" do
      center = center_fixture()
      assert %Ecto.Changeset{} = Settings.change_center(center)
    end
  end
end
