defmodule AvatarsWeb.Router do
  use AvatarsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", AvatarsWeb do
    pipe_through :api

    get "/gen_icon", IconController, :gen_icon
  end
end
