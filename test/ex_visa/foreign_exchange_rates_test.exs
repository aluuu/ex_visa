defmodule ExVisa.ForeignExchangeRatesTest do
  use ExUnit.Case, async: false
  import ClientHelpers
  alias Decimal, as: D
  doctest ExVisa.ForeignExchangeRates

  @eur_currency_code "978"
  @rub_currency_code "643"

  setup_all do
    HTTPoison.start

    :ok
  end

  test "fetches conversion rate" do
    D.set_context(%D.Context{D.get_context | precision: 4})

    request = %{destinationCurrencyCode: @rub_currency_code,
                sourceCurrencyCode: @eur_currency_code,
                sourceAmount: "1"}
    response = ExVisa.ForeignExchangeRates.get(request, client(test_user, test_password))

    assert Map.has_key?(response, "conversionRate")

    rate = response |> Map.get("conversionRate") |> D.new
    assert D.compare(D.new("0"), rate)

    amount = response |> Map.get("destinationAmount") |> D.new
    assert D.equal?(D.mult(D.new(1), rate), amount)
  end
end
