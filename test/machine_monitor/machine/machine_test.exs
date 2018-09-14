defmodule MachineMonitor.MachineTest do
  use MachineMonitor.DataCase

  alias MachineMonitor.Machine
  alias MachineMonitor.Accounts
  alias MachineMonitor.Settings

  setup do
    %{machine: machine_fixture(), center: center_fixture()}
  end

  @machine_attrs %{name: "MRW 0021", password: "fjalkdjfakdjfl"}
  defp machine_fixture() do
    {:ok, %Accounts.Machine{} = machine} = Accounts.create_machine(@machine_attrs)
    machine
  end

  @center_attrs %{name: "FA3453KHL", code: "Some Center"}
  defp center_fixture() do
    {:ok, %Settings.Center{} = center} = Settings.create_center(@center_attrs)
    center
  end

  describe "deployments" do
    alias MachineMonitor.Machine.Deployment

    @valid_attrs %{
      center_id: nil,
      ended_on: ~N[2010-04-17 14:00:00.000000],
      started_on: ~N[2010-04-17 14:00:00.000000],
      machine_id: nil
    }
    @update_attrs %{ended_on: ~N[2011-05-18 15:01:01.000000], started_on: ~N[2011-05-18 15:01:01.000000]}
    @invalid_attrs %{ended_on: nil, started_on: nil, machine_id: nil, center_id: nil}

    def deployment_fixture(attrs \\ %{}) do
      {:ok, deployment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Machine.create_deployment()

      deployment
    end

    test "list_deployments/0 returns all deployments",
         %{
           machine: %{
             id: machine_id
           },
           center: %{
             id: center_id
           }
         } do
      deployment_fixture(%{machine_id: machine_id, center_id: center_id})
      assert Machine.list_deployments()
             |> Enum.count() == 1
    end

    test "get_deployment!/1 returns the deployment with given id",
         %{
           machine: %{
             id: machine_id
           },
           center: %{
             id: center_id
           }
         } do
      deployment = deployment_fixture(%{machine_id: machine_id, center_id: center_id})
      assert Machine.get_deployment!(deployment.id) == deployment
    end

    test "create_deployment/1 with valid data creates a deployment",
         %{
           machine: %{
             id: machine_id
           },
           center: %{
             id: center_id
           }
         } do
      assert {:ok, %Deployment{} = deployment} = Machine.create_deployment(
               %{@valid_attrs | machine_id: machine_id, center_id: center_id}
             )
      assert deployment.ended_on == ~N[2010-04-17 14:00:00.000000]
      assert deployment.started_on == ~N[2010-04-17 14:00:00.000000]
    end

    test "create_deployment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Machine.create_deployment(@invalid_attrs)
    end

    test "update_deployment/2 with valid data updates the deployment",
         %{
           machine: %{
             id: machine_id
           },
           center: %{
             id: center_id
           }
         } do
      deployment = deployment_fixture(%{machine_id: machine_id, center_id: center_id})
      assert {:ok, deployment} = Machine.update_deployment(deployment, @update_attrs)
      assert %Deployment{} = deployment
      assert deployment.ended_on == ~N[2011-05-18 15:01:01.000000]
      assert deployment.started_on == ~N[2011-05-18 15:01:01.000000]
    end

    test "update_deployment/2 with invalid data returns error changeset",
         %{
           machine: %{
             id: machine_id
           },
           center: %{
             id: center_id
           }
         } do
      deployment = deployment_fixture(%{machine_id: machine_id, center_id: center_id})
      assert {:error, %Ecto.Changeset{}} = Machine.update_deployment(deployment, @invalid_attrs)
      assert deployment == Machine.get_deployment!(deployment.id)
    end

    test "delete_deployment/1 deletes the deployment",
         %{
           machine: %{
             id: machine_id
           },
           center: %{
             id: center_id
           }
         } do
      deployment = deployment_fixture(%{machine_id: machine_id, center_id: center_id})
      assert {:ok, %Deployment{}} = Machine.delete_deployment(deployment)
      assert_raise Ecto.NoResultsError, fn -> Machine.get_deployment!(deployment.id) end
    end

    test "change_deployment/1 returns a deployment changeset",
         %{
           machine: %{
             id: machine_id
           },
           center: %{
             id: center_id
           }
         } do
      deployment = deployment_fixture(%{machine_id: machine_id, center_id: center_id})
      assert %Ecto.Changeset{} = Machine.change_deployment(deployment)
    end
  end

  describe "issues" do
    alias MachineMonitor.Machine.Issue

    @valid_attrs %{
      machine_id: nil,
      reported_to: "Some Name",
      description: "some description",
      observation: "some observation",
      occurred_on: ~N[2010-04-17 14:00:00.000000],
      reported_on: ~N[2010-04-17 14:00:00.000000],
      resolved: true,
      resolved_on: ~N[2010-04-17 14:00:00.000000]
    }
    @update_attrs %{
      reported_to: "Some Updated Name",
      description: "some updated description",
      observation: "some updated observation",
      occurred_on: ~N[2011-05-18 15:01:01.000000],
      reported_on: ~N[2011-05-18 15:01:01.000000],
      resolved_on: ~N[2011-05-18 15:01:01.000000]
    }
    @invalid_attrs %{
      reported_to: nil,
      machine_id: nil,
      description: nil,
      observation: nil,
      occurred_on: nil,
      reported_on: nil,
      resolved: nil,
      resolved_on: nil
    }

    def issue_fixture(attrs \\ %{}) do
      {:ok, issue} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Machine.create_issue()

      issue
    end

    test "list_issues/0 returns all issues",
         %{
           machine: %{
             id: machine_id
           }
         } do
      issue_fixture(%{machine_id: machine_id})
      assert Machine.list_issues()
             |> Enum.count() == 1
    end

    test "get_issue!/1 returns the issue with given id",
         %{
           machine: %{
             id: machine_id
           }
         } do
      issue = issue_fixture(%{machine_id: machine_id})
      assert Machine.get_issue!(issue.id) == issue
    end

    test "create_issue/1 with valid data creates a issue",
         %{
           machine: %{
             id: machine_id
           }
         } do
      assert {:ok, %Issue{} = issue} = Machine.create_issue(%{@valid_attrs | machine_id: machine_id})
      assert issue.description == "some description"
      assert issue.observation == "some observation"
      assert issue.occurred_on == ~N[2010-04-17 14:00:00.000000]
      assert issue.reported_on == ~N[2010-04-17 14:00:00.000000]
      assert issue.resolved_on == ~N[2010-04-17 14:00:00.000000]
    end

    test "create_issue/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Machine.create_issue(@invalid_attrs)
    end

    test "update_issue/2 with valid data updates the issue",
         %{
           machine: %{
             id: machine_id
           }
         }  do
      issue = issue_fixture(%{machine_id: machine_id})
      assert {:ok, issue} = Machine.update_issue(issue, @update_attrs)
      assert %Issue{} = issue
      assert issue.description == "some updated description"
      assert issue.observation == "some updated observation"
      assert issue.occurred_on == ~N[2011-05-18 15:01:01.000000]
      assert issue.reported_on == ~N[2011-05-18 15:01:01.000000]
      assert issue.resolved_on == ~N[2011-05-18 15:01:01.000000]
    end

    test "update_issue/2 with invalid data returns error changeset", %{
      machine: %{
        id: machine_id
      }
    }  do
      issue = issue_fixture(%{machine_id: machine_id})
      assert {:error, %Ecto.Changeset{}} = Machine.update_issue(issue, @invalid_attrs)
      assert issue == Machine.get_issue!(issue.id)
    end

    test "delete_issue/1 deletes the issue",
         %{
           machine: %{
             id: machine_id
           }
         } do
      issue = issue_fixture(%{machine_id: machine_id})
      assert {:ok, %Issue{}} = Machine.delete_issue(issue)
      assert_raise Ecto.NoResultsError, fn -> Machine.get_issue!(issue.id) end
    end

    test "change_issue/1 returns a issue changeset",
         %{
           machine: %{
             id: machine_id
           }
         } do
      issue = issue_fixture(%{machine_id: machine_id})
      assert %Ecto.Changeset{} = Machine.change_issue(issue)
    end
  end

    describe "logs" do
      alias MachineMonitor.Machine.Log

      @valid_attrs %{machine_id: nil, action: "some action", date: ~N[2010-04-17 14:00:00.000000], user: "some user"}
      @update_attrs %{action: "some updated action", date: ~N[2011-05-18 15:01:01.000000], user: "some updated user"}
      @invalid_attrs %{machine_id: nil, action: nil, date: nil, user: nil}

      def log_fixture(attrs \\ %{}) do
        {:ok, log} =
          attrs
          |> Enum.into(@valid_attrs)
          |> Machine.create_log()

        log
      end

      test "list_logs/0 returns all logs", %{machine: %{id: machine_id}} do
        log_fixture(%{machine_id: machine_id})
        assert Machine.list_logs() |> Enum.count() == 1
      end

      test "get_log!/1 returns the log with given id", %{machine: %{id: machine_id}} do
        log = log_fixture(%{machine_id: machine_id})
        assert Machine.get_log!(log.id) == log
      end

      test "create_log/1 with valid data creates a log", %{machine: %{id: machine_id}} do
        assert {:ok, %Log{} = log} = Machine.create_log(%{@valid_attrs | machine_id: machine_id})
        assert log.action == "some action"
        assert log.date == ~N[2010-04-17 14:00:00.000000]
        assert log.user == "some user"
      end

      test "create_log/1 with invalid data returns error changeset" do
        assert {:error, %Ecto.Changeset{}} = Machine.create_log(@invalid_attrs)
      end

      test "update_log/2 with valid data updates the log", %{machine: %{id: machine_id}} do
        log = log_fixture(%{machine_id: machine_id})
        assert {:ok, log} = Machine.update_log(log, @update_attrs)
        assert %Log{} = log
        assert log.action == "some updated action"
        assert log.date == ~N[2011-05-18 15:01:01.000000]
        assert log.user == "some updated user"
      end

      test "update_log/2 with invalid data returns error changeset", %{machine: %{id: machine_id}} do
        log = log_fixture(%{machine_id: machine_id})
        assert {:error, %Ecto.Changeset{}} = Machine.update_log(log, @invalid_attrs)
        assert log == Machine.get_log!(log.id)
      end

      test "delete_log/1 deletes the log", %{machine: %{id: machine_id}} do
        log = log_fixture(%{machine_id: machine_id})
        assert {:ok, %Log{}} = Machine.delete_log(log)
        assert_raise Ecto.NoResultsError, fn -> Machine.get_log!(log.id) end
      end

      test "change_log/1 returns a log changeset", %{machine: %{id: machine_id}} do
        log = log_fixture(%{machine_id: machine_id})
        assert %Ecto.Changeset{} = Machine.change_log(log)
      end
    end

    describe "monitors" do
      alias MachineMonitor.Machine.Monitor

      @valid_attrs %{machine_id: nil,
        applications: [
          %{"name" => "notepad", "path" => "c\\files\\notepad.exe", "display" => "Notepad"}
        ],
        network: [
          %{"key" => "ip", "value" => "1.1.1.1"}, %{"key" => "interface", "value" => "mobile"}
        ],
        services: [
          %{"name" => "notepad", "path" => "c\\files\\notepad.exe", "display" => "Notepad"}
        ],
        status: 1}
      @update_attrs %{status: 0}
      @invalid_attrs %{machine_id: nil, applications: nil, network: nil, services: nil, status: nil}

      def monitor_fixture(attrs \\ %{}) do
        {:ok, monitor} =
          attrs
          |> Enum.into(@valid_attrs)
          |> Machine.create_monitor()

        monitor
      end

      test "list_monitors/0 returns all monitors", %{machine: %{id: machine_id}} do
        monitor_fixture(%{machine_id: machine_id})
        assert Machine.list_monitors() |> Enum.count() == 1
      end

      test "get_monitor!/1 returns the monitor with given id", %{machine: %{id: machine_id}} do
        monitor = monitor_fixture(%{machine_id: machine_id})
        assert Machine.get_monitor!(monitor.id) == monitor
      end

      test "create_monitor/1 with valid data creates a monitor", %{machine: %{id: machine_id}} do
        assert {:ok, %Monitor{} = monitor} = Machine.create_monitor(%{@valid_attrs | machine_id: machine_id})
        assert monitor.applications == @valid_attrs.applications
        assert monitor.network == @valid_attrs.network
        assert monitor.services == @valid_attrs.services
        assert monitor.status == 1
      end

      test "create_monitor/1 with invalid data returns error changeset" do
        assert {:error, %Ecto.Changeset{}} = Machine.create_monitor(@invalid_attrs)
      end

      test "update_monitor/2 with valid data updates the monitor", %{machine: %{id: machine_id}} do
        monitor = monitor_fixture(%{machine_id: machine_id})
        assert {:ok, monitor} = Machine.update_monitor(monitor, @update_attrs)
        assert %Monitor{} = monitor
        assert monitor.applications == @valid_attrs.applications
        assert monitor.network == @valid_attrs.network
        assert monitor.services == @valid_attrs.services
        assert monitor.status == 0
      end

      test "update_monitor/2 with invalid data returns error changeset", %{machine: %{id: machine_id}} do
        monitor = monitor_fixture(%{machine_id: machine_id})
        assert {:error, %Ecto.Changeset{}} = Machine.update_monitor(monitor, @invalid_attrs)
        assert monitor == Machine.get_monitor!(monitor.id)
      end

      test "delete_monitor/1 deletes the monitor", %{machine: %{id: machine_id}} do
        monitor = monitor_fixture(%{machine_id: machine_id})
        assert {:ok, %Monitor{}} = Machine.delete_monitor(monitor)
        assert_raise Ecto.NoResultsError, fn -> Machine.get_monitor!(monitor.id) end
      end

      test "change_monitor/1 returns a monitor changeset", %{machine: %{id: machine_id}} do
        monitor = monitor_fixture(%{machine_id: machine_id})
        assert %Ecto.Changeset{} = Machine.change_monitor(monitor)
      end
    end

  describe "locations" do
    alias MachineMonitor.Machine.Location

    @valid_attrs %{latitude: 42.02, longitude: -42.02, timestamp: 475755232, machine_id: nil}
    @update_attrs %{latitude: 43.02, longitude: -43.02, timestamp: 445253653}
    @invalid_attrs %{latitude: nil, longitude: nil, timestamp: nil, machine_id: nil}

    def location_fixture(attrs \\ %{}) do
      {:ok, location} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Machine.create_location()

      location
    end

    test "list_locations/0 returns all locations", %{machine: %{id: id}} do
#      %{id: id} = machine_fixture()
      location = location_fixture(%{machine_id: id})
      assert Machine.list_locations() == [location]
    end

    test "get_location!/1 returns the location with given id", %{machine: %{id: id}} do
#      %{id: id} = machine_fixture()
      location = location_fixture(%{machine_id: id})
      assert Machine.get_location!(location.id) == location
    end

    test "create_location/1 with valid data creates a location", %{machine: %{id: id}} do
#      %{id: id} = machine_fixture()
      assert {:ok, %Location{} = location} = Machine.create_location(%{@valid_attrs | machine_id: id})
    end

    test "create_location/1 with invalid data returns error changeset" do
#      %{id: id} = machine_fixture()
      assert {:error, %Ecto.Changeset{}} = Machine.create_location(@invalid_attrs)
    end

    test "update_location/2 with valid data updates the location", %{machine: %{id: id}} do
#      %{id: id} = machine_fixture()
      location = location_fixture(%{machine_id: id})
      assert {:ok, location} = Machine.update_location(location, @update_attrs)
      assert %Location{} = location
    end

    test "update_location/2 with invalid data returns error changeset", %{machine: %{id: id}} do
#      %{id: id} = machine_fixture()
      location = location_fixture(%{machine_id: id})
      assert {:error, %Ecto.Changeset{}} = Machine.update_location(location, @invalid_attrs)
      assert location == Machine.get_location!(location.id)
    end

    test "delete_location/1 deletes the location", %{machine: %{id: id}} do
#      %{id: id} = machine_fixture()
      location = location_fixture(%{machine_id: id})
      assert {:ok, %Location{}} = Machine.delete_location(location)
      assert_raise Ecto.NoResultsError, fn -> Machine.get_location!(location.id) end
    end

    test "change_location/1 returns a location changeset", %{machine: %{id: id}} do
#      %{id: id} = machine_fixture()
      location = location_fixture(%{machine_id: id})
      assert %Ecto.Changeset{} = Machine.change_location(location)
    end
  end
end
