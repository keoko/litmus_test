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
    get "/question", ResponseController, :question
    #post "/apply/:name", ResponseController, :create
    resources "/interviews", InterviewController
    resources "/responses", ResponseController
    resources "/solutions", SolutionController

    # get / -> home page
    # get /create -> :new interview
    # post /create -> :create interview
    # get /apply/:name -> :new solution (user + password)
    # post /apply/:name -> :create solution (user + password)
    # get /question/:name -> :show questions
    #
    # /interview/:name -> show questions + answers
    # post /record/:name -> 
  end

  # Other scopes may use custom stacks.
  # scope "/api", LitmusTest do
  #   pipe_through :api
  # end
end
