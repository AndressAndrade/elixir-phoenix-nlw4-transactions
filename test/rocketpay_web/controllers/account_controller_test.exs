defmodule RocketpayWeb.AccountsControllerTest do
  use RocketpayWeb.ConnCase, async: true
  # use RocketpayWeb, :controller

  alias Rocketpay.{Account, User}
  # alias Rocketpay.Accounts.Transactions.Response, as: TransactionResponse

  # action_fallback RocketpayWeb.FallbackController

  # def deposit(conn, params) do
  #   with {:ok, %Account{} = account } <- Rocketpay.deposit(params) do
  #     conn
  #     |> put_status(:ok)
  #     |> render("update.json", account: account)
  #   end
  # end
  describe "deposit/2" do

    # Preparação de dados para teste do controller, para testar esse controller, é necessário que um usuário tenha sido criado
    setup %{conn: conn} do
      params = %{
        age: 35,
        email: "andressa@andrade.com",
        name: "Andressa",
        nickname: "Dessa",
        password: "123456"
      }

      {:ok, %User{account: %Account{id: account_id}}} = Rocketpay.create_user(params)
      conn = put_req_header(conn, "authorization", "Basic Z2Y3SnlOMDRXa05tOnRvZUZSekZYZnRMag==")
      {:ok, conn: conn, account_id: account_id}
    end
    test "when all params are valid, deposit is done sucessfully", %{conn: conn, account_id: account_id} do
      params = %{
        "value" => "35"
      }
      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:ok)

      assert  %{
        "account" => %{"balance" => "35.00", "id" => _id},
        "message" => "Balance changed sucessfully"
      } = response
    end
    test "when there are invalid params, returns an error", %{conn: conn, account_id: account_id} do
      params = %{
        "value" => "banana"
      }
      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:bad_request)

      assert  %{
        "message" => "Invalid deposit value!"
      } == response
    end
  end

  # def withdraw(conn, params) do
  #   # Acionar uma task, e devolver uma resposta enquanto ainda está processando
  #   # Task.start(fn -> Rocketpay.transaction(params) end)
  #   # conn
  #   #   |> put_status(:no_content)
  #   #   |> text("")
  #   # Possibilidade de criar tasks
  #   # IO.puts("Iniciando task")
  #   # task = Task.async(fn -> Rocketpay.transaction(params) end)
  #   # with {:ok, %Account{} = account } <- Task.await(task) do

  #   with {:ok, %Account{} = account } <- Rocketpay.withdraw(params) do
  #     conn
  #     |> put_status(:ok)
  #     |> render("update.json", account: account)
  #   end
  # end

  # def transaction(conn, params) do
  #   with {:ok, %TransactionResponse{} = transaction } <- Rocketpay.transaction(params) do
  #     conn
  #     |> put_status(:ok)
  #     |> render("transaction.json", transaction: transaction)
  #   end
  # end

end
