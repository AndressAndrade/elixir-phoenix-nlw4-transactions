defmodule Rocketpay.NumbersTest do
  use ExUnit.Case, async: true

  alias Rocketpay.Numbers

  describe "sum_from_file/1" do
    test "when there is a file with the given name, return the sum of numbers" do
      response = Numbers.sum_from_file("numbers")
      expexted_response = {:ok, %{result: 37}}
      assert response == expexted_response
    end
    test "when there is no file with the given name, return an error" do
      response = Numbers.sum_from_file("number")
      expexted_response = {:error, %{message: "Invalid file"}}
      assert response == expexted_response
    end
  end

end
