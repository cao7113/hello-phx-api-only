defmodule HiWeb.Router do
  use HiWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", HiWeb do
    pipe_through(:api)

    get("/", ApiController, :home)
  end
end
