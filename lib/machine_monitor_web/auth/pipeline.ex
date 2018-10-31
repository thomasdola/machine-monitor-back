defmodule MachineMonitorWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
      otp_app: :machine_monitor,
      error_handler: MachineMonitorWeb.Auth.ErrorHandler,
      module: MachineMonitorWeb.Auth.Guardian

  # If there is a session token, restrict it to an access token and validate it
  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  # If there is an authorization header, restrict it to an access token and validate it
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}, realm: "Bearer"
  # Load the user if either of the verifications worked
  plug Guardian.Plug.LoadResource, allow_blank: true
end