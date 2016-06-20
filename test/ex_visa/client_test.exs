defmodule ExVisa.ClientTest do
  use ExUnit.Case, async: false
  import ClientHelpers
  doctest ExVisa.Client

  setup_all do
    HTTPoison.start

    :ok
  end

  test "client properly authorizes requests" do
    {status, _response} = ExVisa.get("/", client(test_user, test_password))
    assert status == 404

    {status, response} = ExVisa.get("/", client("", ""))
    assert {status, response} == {400, :decode_error}
  end
end
