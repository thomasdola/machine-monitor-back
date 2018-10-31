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

    @center_location_sketch "some file path"

    @center_contact %{
      name: "some name",
      phone: "some phone"
    }
    @center_recomendation %{
      preferred_network: "pr net",
      backup_network: "bc net",
      recomended: true
    }
    @center_location %{
      ghana_post_gps: "some gps",
      longitude: 0.55555,
      latitude: 0.5555,
      sketch: @center_location_sketch
    }

    @valid_attrs %{code: "some code", name: "some name", location: @center_location, 
      contact: @center_contact, recomendation: @center_recomendation}
    @update_attrs %{code: "some updated code", name: "some updated name"}
    @invalid_attrs %{code: nil, name: nil, status: nil}

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

  describe "deployments" do
    alias MachineMonitor.Settings.Deployment

    @valid_attrs %{end_date: "2010-04-17 14:00:00.000000Z", start_date: "2010-04-17 14:00:00.000000Z", status: 42, center_id: nil}
    @update_attrs %{end_date: "2011-05-18 15:01:01.000000Z", start_date: "2011-05-18 15:01:01.000000Z", status: 43}
    @invalid_attrs %{end_date: nil, start_date: nil, status: nil, center_id: nil}

    @valid_center_attrs %{code: "some code", name: "some name"}

    def deployment_fixture(attrs \\ %{}) do
      {:ok, %{id: center_id}} = Settings.create_center(@valid_center_attrs)
      {:ok, deployment} =
        attrs
        |> Enum.into(%{@valid_attrs| center_id: center_id})
        |> Settings.create_deployment()

      deployment
    end

    test "list_deployments/0 returns all deployments" do
      deployment = deployment_fixture()
      assert Settings.list_deployments() == [deployment]
    end

    test "get_deployment!/1 returns the deployment with given id" do
      deployment = deployment_fixture()
      assert Settings.get_deployment!(deployment.id) == deployment
    end

    test "create_deployment/1 with valid data creates a deployment" do
      {:ok, %{id: center_id}} = Settings.create_center(@valid_center_attrs)
      assert {:ok, %Deployment{} = deployment} = Settings.create_deployment(%{@valid_attrs| center_id: center_id})
      assert deployment.end_date == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert deployment.start_date == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert deployment.status == 42
    end

    test "create_deployment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_deployment(@invalid_attrs)
    end

    test "update_deployment/2 with valid data updates the deployment" do
      deployment = deployment_fixture()
      assert {:ok, deployment} = Settings.update_deployment(deployment, @update_attrs)
      assert %Deployment{} = deployment
      assert deployment.end_date == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert deployment.start_date == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert deployment.status == 43
    end

    test "update_deployment/2 with invalid data returns error changeset" do
      deployment = deployment_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_deployment(deployment, @invalid_attrs)
      assert deployment == Settings.get_deployment!(deployment.id)
    end

    test "delete_deployment/1 deletes the deployment" do
      deployment = deployment_fixture()
      assert {:ok, %Deployment{}} = Settings.delete_deployment(deployment)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_deployment!(deployment.id) end
    end

    test "change_deployment/1 returns a deployment changeset" do
      deployment = deployment_fixture()
      assert %Ecto.Changeset{} = Settings.change_deployment(deployment)
    end
  end

  describe "networks" do
    alias MachineMonitor.Settings.Network

    @valid_attrs %{operator: "some name", type: "some network type"}
    @update_attrs %{operator: "some updated name"}
    @invalid_attrs %{operator: nil, type: nil}

    def network_fixture(attrs \\ %{}) do
      {:ok, network} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_network()

      network
    end

    test "list_networks/0 returns all networks" do
      network = network_fixture()
      assert Settings.list_networks() == [network]
    end

    test "get_network!/1 returns the network with given id" do
      network = network_fixture()
      assert Settings.get_network!(network.id) == network
    end

    test "create_network/1 with valid data creates a network" do
      assert {:ok, %Network{} = network} = Settings.create_network(@valid_attrs)
      assert network.operator == "some name"
    end

    test "create_network/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_network(@invalid_attrs)
    end

    test "update_network/2 with valid data updates the network" do
      network = network_fixture()
      assert {:ok, network} = Settings.update_network(network, @update_attrs)
      assert %Network{} = network
      assert network.operator == "some updated name"
    end

    test "update_network/2 with invalid data returns error changeset" do
      network = network_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_network(network, @invalid_attrs)
      assert network == Settings.get_network!(network.id)
    end

    test "delete_network/1 deletes the network" do
      network = network_fixture()
      assert {:ok, %Network{}} = Settings.delete_network(network)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_network!(network.id) end
    end

    test "change_network/1 returns a network changeset" do
      network = network_fixture()
      assert %Ecto.Changeset{} = Settings.change_network(network)
    end
  end

  describe "printers" do
    alias MachineMonitor.Settings.Printer

    @valid_attrs %{laminator: "some laminator", serial: "some serial"}
    @update_attrs %{laminator: "some updated laminator", serial: "some updated serial"}
    @invalid_attrs %{laminator: nil, serial: nil}

    def printer_fixture(attrs \\ %{}) do
      {:ok, printer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Settings.create_printer()

      printer
    end

    test "list_printers/0 returns all printers" do
      printer = printer_fixture()
      assert Settings.list_printers() == [printer]
    end

    test "get_printer!/1 returns the printer with given id" do
      printer = printer_fixture()
      assert Settings.get_printer!(printer.id) == printer
    end

    test "create_printer/1 with valid data creates a printer" do
      assert {:ok, %Printer{} = printer} = Settings.create_printer(@valid_attrs)
      assert printer.laminator == "some laminator"
      assert printer.serial == "some serial"
    end

    test "create_printer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_printer(@invalid_attrs)
    end

    test "update_printer/2 with valid data updates the printer" do
      printer = printer_fixture()
      assert {:ok, printer} = Settings.update_printer(printer, @update_attrs)
      assert %Printer{} = printer
      assert printer.laminator == "some updated laminator"
      assert printer.serial == "some updated serial"
    end

    test "update_printer/2 with invalid data returns error changeset" do
      printer = printer_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_printer(printer, @invalid_attrs)
      assert printer == Settings.get_printer!(printer.id)
    end

    test "delete_printer/1 deletes the printer" do
      printer = printer_fixture()
      assert {:ok, %Printer{}} = Settings.delete_printer(printer)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_printer!(printer.id) end
    end

    test "change_printer/1 returns a printer changeset" do
      printer = printer_fixture()
      assert %Ecto.Changeset{} = Settings.change_printer(printer)
    end
  end
end
