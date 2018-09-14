defmodule MachineMonitorWeb.ActionFallbackController do
  use Phoenix.Controller

  def call(conn, {:error, %Ecto.Changeset{}}) do
    conn
    |> put_status(:bad_request)
    |> render(MachineMonitorWeb.ErrorView, "400.json", %{})
  end

  def call(conn, nil) do
    conn
    |> put_status(:bad_request)
    |> render(MachineMonitorWeb.ErrorView, "404.json", %{})
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> render(MachineMonitorWeb.ErrorView, "401.json", %{})
  end

  def call(conn, {:error, :invalid_credentials}) do
    conn
    |> put_status(:unauthorized)
    |> render(MachineMonitorWeb.ErrorView, "401.json", %{})
  end
end