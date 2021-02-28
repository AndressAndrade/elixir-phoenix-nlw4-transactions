defmodule Rocketpay.Token.Generate do
  alias Rocketpay.{Repo, User}

  # %{"id" => id, "value" => value}
  def call( %{"nickname" => nickname}) do
    user = Repo.get_by(User, nickname: nickname)
    case Rocketpay.Guardian.encode_and_sign(user) do
      {:ok, token, _claims} -> {:ok, token}
      {:error, result} -> {:error, result}
    end
  end

end
