defmodule RocketpayWeb.TokenView do
  def render( "generated.json", %{token: token}) do
    %{
      message: "Token generated",
      token: token
    }
  end
end
