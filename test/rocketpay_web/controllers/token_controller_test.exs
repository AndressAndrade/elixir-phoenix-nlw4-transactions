defmodule RocketpayWeb.TokenControllerTest do
  use RocketpayWeb.ConnCase, async: true

  describe "generate/1" do

    # Preparação de dados para teste do controller, para testar esse controller, é necessário que um usuário tenha sido criado
    setup %{conn: conn} do
      params = %{
        age: 35,
        email: "andressa@andrade.com",
        name: "Andressa",
        nickname: "Dessa",
        password: "123456"
      }

      {:ok, _info} = Rocketpay.create_user(params)
      conn = put_req_header(conn, "authorization", "Basic Z2Y3SnlOMDRXa05tOnRvZUZSekZYZnRMag==")
      {:ok, conn: conn, nickname: params.nickname}
    end
    test "when all params are valid, deposit is done sucessfully", %{conn: conn, nickname: nickname} do
      params = %{
        "nickname" => nickname
      }
      response =
        conn
        |> post(Routes.token_path(conn, :generate, params))
        |> json_response(:ok)

      assert  %{
        "token" => _token,
        "message" => "Token generated"
      } = response
    end
  end

end
