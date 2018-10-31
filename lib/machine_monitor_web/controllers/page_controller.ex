defmodule MachineMonitorWeb.PageController do
  use MachineMonitorWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
