defmodule ExVisa do
  use HTTPoison.Base
  alias ExVisa.Client

  @user_agent [{"User-agent", "ex_visa"}]
  @content_type [{"Content-Type", "application/json"}]
  @accept [{"Accept", "application/json"}]

  @type response :: {integer, any} | :jsx.json_term

  def delete(path, client, body \\ "") do
    _request(:delete, url(client, path), client.auth, body)
  end

  def post(path, client, body \\ "", content_type \\ nil) do
    _request(:post, url(client, path), client.auth, body)
  end

  def patch(path, client, body \\ "") do
    _request(:patch, url(client, path), client.auth, body)
  end

  def put(path, client, body \\ "") do
    _request(:put, url(client, path), client.auth, body)
  end

  def get(path, client, params \\ [], options \\ []) do
    _request(:get, url(client, path), client.auth, params: params)
  end

  def _request(method, url, auth, body \\ "") do
    json_request(method, url, body, authorization_headers(auth), ssl: auth.ssl)
  end

  def json_request(method, url, body \\ "", extra_headers \\ [], options \\ []) do
    headers = extra_headers ++ @user_agent ++ @content_type ++ @accept
    raw_request(method, url, JSX.encode!(body), headers, options)
  end

  def raw_request(method, url, body \\ "", headers \\ [], options \\ []) do
    request!(method, url, body, headers, options) |> process_response
  end

  @spec authorization_headers(Client.auth) :: list
  def authorization_headers(%{user: user, password: password}) do
    userpass = user <> ":" <> password
    [{"Authorization", "Basic #{:base64.encode(userpass)}"}]
  end

  @spec url(client :: Client.t, path :: binary) :: binary
  defp url(_client = %Client{endpoint: endpoint}, path) do
    endpoint <> path
  end

  @spec process_response_body(binary) :: term
  def process_response_body(""), do: nil
  def process_response_body(body) do
    case JSX.decode(body) do
      {:ok, body} -> body
      {_, _} -> :decode_error
    end
  end

  @spec process_response(HTTPoison.Response.t) :: response
  def process_response(%HTTPoison.Response{status_code: 200, body: body}), do: body
  def process_response(%HTTPoison.Response{status_code: status_code, body: body }), do: { status_code, body }
end
