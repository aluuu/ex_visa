defmodule ExVisa.Client do
  defstruct auth: nil, endpoint: "https://api.visa.com/"

  @type ssl :: [cacertfile: binary, certfile: binary, keyfile: binary]
  @type auth :: %{user: binary, password: binary, ssl: ssl}
  @type t :: %__MODULE__{auth: auth, endpoint: binary}

  @spec new(auth) :: t
  def new(auth) do
    %__MODULE__{auth: auth}
  end

  @spec new(auth, binary) :: t
  def new(auth, endpoint) do
    %__MODULE__{auth: auth, endpoint: endpoint}
  end
end
