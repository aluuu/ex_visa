defmodule ExVisa.ForeignExchangeRates do
  import ExVisa
  alias ExVisa.Client

  @type short_request :: %{destinationCurrencyCode: binary,
                           sourceCurrencyCode: binary,
                           sourceAmount: binary}

  @type full_request :: %{destinationCurrencyCode: binary,
                          sourceCurrencyCode: binary,
                          sourceAmount: binary,
                          markUpRate: binary,
                          systemsTraceAuditNumber: binary,
                          retrievalReferenceNumber: binary,
                          acquiringBin: binary,
                          acquirerCountryCode: binary}

  @type request :: short_request | full_request

  @type response :: %{conversionRate: binary,
                      destinationAmount: binary,
                      markUpRateApplied: binary,
                      originalDestnAmtBeforeMarkUp: binary}

  @spec get(request, Client.t) :: response
  def get(request, client) do
    ExVisa.post("/forexrates/v1/foreignexchangerates", client, request)
  end
end
