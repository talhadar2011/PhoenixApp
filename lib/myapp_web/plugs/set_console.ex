defmodule MyappWeb.Plugs.SetConsole do
  def init(opts), do: opts

  def call(%Plug.Conn{}=conn, _opts) do
    IO.inspect("SetConsole Plug Called")
    conn
  end
end
