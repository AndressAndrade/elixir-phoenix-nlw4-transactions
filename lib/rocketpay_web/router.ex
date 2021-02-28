defmodule RocketpayWeb.Router do
  use RocketpayWeb, :router
  import Plug.BasicAuth

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug :basic_auth, Application.compile_env(:rocketpay, :basic_auth)
  end

  scope "/api/v1", RocketpayWeb do
    pipe_through :api
    get "/:filename", WelcomeController, :index
  end

  # APIs autenticadas
  scope "/api/v1/users", RocketpayWeb do
    pipe_through [:api, :auth]

    post "/", UsersController, :create
  end

  # APIs autenticadas
  scope "/api/v1/token", RocketpayWeb do
    pipe_through [:api, :auth]

    post "/", TokenController, :generate
  end

  # APIs autenticadas
  scope "/api/v1/accounts", RocketpayWeb do
    pipe_through [:api, :auth]

    post "/:id/deposit", AccountsController, :deposit
    post "/:id/withdraw", AccountsController, :withdraw
    post "/transaction", AccountsController, :transaction
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: RocketpayWeb.Telemetry
    end
  end
end
