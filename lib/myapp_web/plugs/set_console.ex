defmodule MyappWeb.Plugs.SetConsole do
  import Plug.Conn
@validConsoles ["PC","PlayStation","Xbox","SteamBox"]
  def init(default_console), do: default_console

  def call(%Plug.Conn{params: %{"console" => console}} = conn, _default_console)
  when console in @validConsoles
  do
    conn
    |> assign(:console, console)
    |> put_resp_cookie("console", console, max_age: :timer.hours(1))
  end

  def call(%Plug.Conn{cookies: %{"console" => console}} = conn, _default_console)
  when console in @validConsoles
  do
    assign(conn, :console, console)
  end

  def call(conn, default_console) do
    conn
    |> assign(:console, default_console)
    |> put_resp_cookie("console", default_console, max_age: :timer.hours(1))
  end
end
