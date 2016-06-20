# ExVisa

Simple VISA API client.

## Installation

```elixir
   def deps do
      [{:ex_visa, git: "git://github.com/aluuu/ex_visa.git", branch: "master"}]
   end
```

## Usage

```elixir
ssl_config = [cacertfile: path_to_cacert, certfile: path_to_cert, keyfile: path_to_key]
client = ExVisa.Client.new(username, password, ssl: ssl_config)

request = %{destinationCurrencyCode: "978",
            sourceCurrencyCode: "643",
            sourceAmount: "1"}
response = ExVisa.ForeignExchangeRates.get(request, client)
```

## Running tests

First, you should put proper certificates and key files into `test/fixtures` directory:

* `test/fixtures/cacert.pem`
* `test/fixtures/cert.pem`
* `test/fixtures/key.pem`

Then you could run tests like:

    TEST_VISA_USER=<username> TEST_VISA_PASSWORD=<password> mix test
