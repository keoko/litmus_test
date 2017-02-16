defmodule LitmusTest.Router do
  use LitmusTest.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LitmusTest do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/create", InterviewController, :new
    get "/apply/:name", ResponseController, :index
    resources "/interviews", InterviewController
    resources "/responses", ResponseController
  end

  # Other scopes may use custom stacks.
  # scope "/api", LitmusTest do
  #   pipe_through :api
  # end
end
