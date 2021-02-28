defmodule RocketpayWeb.TokenController do
  use RocketpayWeb, :controller

  action_fallback RocketpayWeb.FallbackController

  def generate(conn, params) do
    with {:ok, token } <- Rocketpay.generate_token(params) do
      conn
      |> put_status(:ok)
      |> render("generated.json", token: token)
    end
  end

end
