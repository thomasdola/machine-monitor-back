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

      scope "/roles" do
        get "/", RoleController, :list
        get "/:id", RoleController, :single
        put "/:id", RoleController, :update
        delete "/:id", RoleController, :delete
      end

      scope "/policies" do
        get "/", PolicyController, :list
        get "/:id", PolicyController, :single
        put "/:id", PolicyController, :update
        delete "/:id", PolicyController, :delete
      end

      scope "/gates" do
        get "/", GateController, :index
        get "/:id", GateController, :single
        put "/:id", GateController, :update
        delete "/:id", GateController, :delete
      end

      scope "/entities" do
        get "/", EntityController, :list
        get "/:id", EntityController, :single
        put "/:id", EntityController, :update
        delete "/:id", EntityController, :delete
      end

      scope "/actions" do
        get "/", ActionController, :index
        get "/:id", ActionController, :single
        put "/:id", ActionController, :update
        delete "/:id", ActionController, :delete
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

      scope "/centers" do
        get "/", CenterController, :list
        get "/:id", CenterController, :single
        post "/", CenterController, :add
        put "/:id", CenterController, :update
        delete "/:id", CenterController, :delete
      end

      scope "/settings" do
        
        scope "/applications" do
          get "/", MachineApplicationController, :index
          post "/", MachineApplicationController, :add
          get "/:id", MachineApplicationController, :single
          put "/:id", MachineApplicationController, :update
          delete "/:id", MachineApplicationController, :delete
        end

        scope "/services" do
          get "/", MachineServiceController, :index
          post "/", MachineServiceController, :add
          get "/:id", MachineServiceController, :single
          put "/:id", MachineServiceController, :update
          delete "/:id", MachineServiceController, :delete
        end

        scope "/printers" do
          get "/", PrinterController, :index
          post "/", PrinterController, :add
          get "/:id", PrinterController, :single
          put "/:id", PrinterController, :update
          delete "/:id", PrinterController, :delete
        end

        scope "/networks" do
          get "/", NetworkController, :index          
          post "/", NetworkController, :add
          get "/:id", NetworkController, :single
          put "/:id", NetworkController, :update
          delete "/:id", NetworkController, :delete
        end

      end

      scope "/consumables" do
        
        scope "/cards" do
          get "/", CardController, :index          
          post "/", CardController, :add
          # get "/:id", CardController, :single
          # put "/:id", CardController, :update
          # delete "/:id", CardController, :delete
        end

        scope "/ribbons" do
          get "/", RibbonController, :index          
          post "/", RibbonController, :add
          # get "/:id", RibbonController, :single
          # put "/:id", RibbonController, :update
          # delete "/:id", RibbonController, :delete
        end

        scope "/laminates" do
          get "/", LaminateController, :index          
          post "/", LaminateController, :add
          # get "/:id", LaminateController, :single
          # put "/:id", LaminateController, :update
          # delete "/:id", LaminateController, :delete
        end

        scope "/receipt-paper-rolls" do
          get "/", ReceiptPaperRollController, :index          
          post "/", ReceiptPaperRollController, :add
          # get "/:id", ReceiptPaperRollController, :single
          # put "/:id", ReceiptPaperRollController, :update
          # delete "/:id", ReceiptPaperRollController, :delete
        end

      end

    end
  end

  scope "/", MachineMonitorWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/*sub", PageController, :index
  end
end
