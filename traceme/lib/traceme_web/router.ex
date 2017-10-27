defmodule TracemeWeb.Router do
  use TracemeWeb, :router

  # pipeline :browser do
  #   plug :accepts, ["html"]
  #   plug :fetch_session
  #   plug :fetch_flash
  #   plug :protect_from_forgery
  #   plug :put_secure_browser_headers
  # end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TracemeWeb do
    pipe_through :api

    get "/castles"     , CastleController, :index
    get "/castles_flow", CastleController, :index_flow
    get "/castles_svc" , CastleController, :index_svc
  end
end
