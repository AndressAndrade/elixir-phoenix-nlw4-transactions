defmodule Rocketpay.Users.CreateTest do
  # Permite realizar operações em um banco de dados sandbox
  use Rocketpay.DataCase, async: true

  alias Rocketpay.User
  alias Rocketpay.Users.Create


  describe "call/1" do
    test "when all params are valid, return an user" do
      params = %{
        age: 35,
        email: "andressa@andradea.com",
        name: "Andressa",
        nickname: "Dessaa",
        password: "123456"
      }
      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)
      # Pin operator
      assert %User{name: "Andressa", age: 35, id: ^user_id} = user
    end
    test "nickname can't be blank, return an error" do
      params = %{
        age: 35,
        email: "andressa@andrade.com",
        name: "Andressa",
        password: "123456"
      }
      {:error, changeset} = Create.call(params)
      assert %{nickname: ["can't be blank"]} = errors_on(changeset)
    end
  end

end
