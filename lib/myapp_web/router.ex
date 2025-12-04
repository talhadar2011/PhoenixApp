defmodule MyappWeb.Router do
  use MyappWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {MyappWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug MyappWeb.Plugs.SetConsole, "PC"
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MyappWeb do
    pipe_through :browser

    get "/", PageController, :home

    get "/about", PageController, :about
    get "/contact", PageController, :contact

    # Doctor LiveView Routes
    live "/doctors", DoctorLive.Index, :index
    live "/doctors/new", DoctorLive.Form, :new
    live "/doctors/:id/edit", DoctorLive.Form, :edit

    live "/doctors/:id", DoctorLive.Show, :show
    live "/doctors/:id/show/edit", DoctorLive.Show, :edit
  end

  scope "/api", MyappWeb do
    pipe_through :api

    get "/data", DataController, :index
  end

  if Application.compile_env(:myapp, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: MyappWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
