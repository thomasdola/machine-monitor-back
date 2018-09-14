defmodule MachineMonitorWeb.DeploymentController do
  use MachineMonitorWeb, :controller

  def list(conn, %{"id" => id} = params) do
    render conn, "list.json", deployments: []
  end
end
