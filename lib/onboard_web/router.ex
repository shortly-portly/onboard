defmodule OnboardWeb.Router do
  use OnboardWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {OnboardWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", OnboardWeb do
    pipe_through :browser

    live "/", PageLive, :index

    live "/templates", TemplateLive.Index, :index
    live "/templates/new", TemplateLive.Index, :new
    live "/templates/:id/edit", TemplateLive.Index, :edit

    live "/templates/:id", TemplateLive.Show, :show
    live "/templates/:id/show/edit", TemplateLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", OnboardWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: OnboardWeb.Telemetry
    end
  end
end
