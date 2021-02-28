defmodule RocketpayWeb.AccountsController do
  use RocketpayWeb, :controller

  alias Rocketpay.Account
  alias Rocketpay.Accounts.Transactions.Response, as: TransactionResponse

  action_fallback RocketpayWeb.FallbackController

  def deposit(conn, params) do
    with {:ok, %Account{} = account } <- Rocketpay.deposit(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end
  end

  def withdraw(conn, params) do
    # Acionar uma task, e devolver uma resposta enquanto ainda está processando
    # Task.start(fn -> Rocketpay.transaction(params) end)
    # conn
    #   |> put_status(:no_content)
    #   |> text("")
    # Possibilidade de criar tasks
    # IO.puts("Iniciando task")
    # task = Task.async(fn -> Rocketpay.transaction(params) end)
    # with {:ok, %Account{} = account } <- Task.await(task) do

    with {:ok, %Account{} = account } <- Rocketpay.withdraw(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end
  end

  def transaction(conn, params) do
    with {:ok, %TransactionResponse{} = transaction } <- Rocketpay.transaction(params) do
      conn
      |> put_status(:ok)
      |> render("transaction.json", transaction: transaction)
    end
  end

end
