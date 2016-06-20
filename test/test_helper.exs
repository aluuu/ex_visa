defmodule PathHelpers do
  def fixture_path do
    Path.expand("fixtures", __DIR__)
  end

  def fixture_path(file_path) do
    Path.join fixture_path, file_path
  end
end

defmodule ClientHelpers do
  import PathHelpers


  @cacert fixture_path("cacert.pem")
  @cert fixture_path("cert.pem")
  @key fixture_path("key.pem")

  @sandbox_endpoint "https://sandbox.api.visa.com"

  def test_user, do: System.get_env("TEST_VISA_USER")

  def test_password, do: System.get_env("TEST_VISA_PASSWORD")

  def client(user, password,
             ssl \\ [cacertfile: @cacert, certfile: @cert, keyfile: @key]) do
    ExVisa.Client.new(
      %{user: user, password: password,
        ssl: ssl},
      @sandbox_endpoint)
  end
end

ExUnit.start(max_cases: 1)
