defmodule MachineMonitorWeb.IssueController do
  use MachineMonitorWeb, :controller

  def list(conn, %{"id" => id} = params) do
    render conn, "list.json", issues: []
  end
end
