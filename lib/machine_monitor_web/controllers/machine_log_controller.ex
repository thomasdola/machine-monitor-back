defmodule MachineMonitorWeb.MachineLogController do
  use MachineMonitorWeb, :controller

  def list(conn, %{"id" => id} = params) do
    render conn, "list.json", logs: []
  end
end
