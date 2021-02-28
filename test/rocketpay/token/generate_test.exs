defmodule Rocketpay.Token.GenerateTest do
  # Permite realizar operações em um banco de dados sandbox
  use Rocketpay.DataCase, async: true

  alias Rocketpay.User
  alias Rocketpay.Users.Create
  alias Rocketpay.Token.Generate

  describe "call/1" do
    test "when all params are valid, return an token" do
      params = %{
        age: 35,
        email: "andressa@andradea.com",
        name: "Andressa",
        nickname: "Dessaa",
        password: "123456"
      }
      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)
      response = Generate.call(%{"nickname" => user.nickname})
      # Pin operator
      assert {:ok, _token} = response
    end
  end

end
