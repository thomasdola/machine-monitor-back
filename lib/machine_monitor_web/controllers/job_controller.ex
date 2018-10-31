defmodule MachineMonitorWeb.JobController do
  use MachineMonitorWeb, :controller

  alias MachineMonitor.Settings
  alias MachineMonitorWeb.Serializers.{Application, Service}

  @monitor_network true
  @monitor_user_activity true

  def index(conn, _params) do
    applications = Settings.list_applications() |> Application.to_map()
    services = Settings.list_services() |> Service.to_map()
    render conn, "job.json", network: @monitor_network, user_activity: @monitor_user_activity,
                             applications: applications, services: services
  end
end
