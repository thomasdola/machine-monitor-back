defmodule MachineMonitorWeb.Router do
  use MachineMonitorWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug MachineMonitorWeb.Auth.Pipeline
  end

  pipeline :api_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/", MachineMonitorWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", MachineMonitorWeb do
    pipe_through :api

    scope "/windows" do
      scope "/auth" do
        post "/login", MachineAuthController, :login
        post "/register", MachineAuthController, :register
        scope "/logout" do
          pipe_through :api_auth
          post "/", MachineAuthController, :logout
        end
      end

      scope "/jobs" do
        pipe_through :api_auth
        get "/", JobController, :index
      end
    end

    scope "/browser" do
      scope "/auth" do
        post "/login", UserAuthController, :login
        scope "/logout" do
          pipe_through :api_auth
          post "/", UserAuthController, :logout
        end
      end

      scope "/machines" do
        get "/", MachineController, :list

        scope "/:id" do
          get "/", MachineController, :single

          scope "/actions" do
            post "/change-password", MachineController, :change_password
            get "/shut-down", MachineController, :shut_down
            post "/start-application", MachineController, :start_application
            post "/stop-application", MachineController, :stop_application
            post "/start-service", MachineController, :start_service
            post "/stop-service", MachineController, :stop_service
          end

          scope "/deployments" do
            get "/", DeploymentController, :list
            post "/", DeploymentController, :add
            put "/:deployment_id", DeploymentController, :update
          end

          scope "/issues" do
            get "/", IssueController, :list
            post "/", IssueController, :add
            put "/:issue_id", IssueController, :update
          end

          scope "/logs" do
            get "/", MachineLogController, :list
          end
        end
      end
    end
  end
end
