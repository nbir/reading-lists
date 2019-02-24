defmodule ReadingListsWeb.Router do
  use ReadingListsWeb, :router

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

  scope "/", ReadingListsWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", ReadingListsWeb do
    pipe_through :api

    resources "/lists", ListController, [:index, :show, :create, :update, :delete]
    resources "/links", LinkController, [:index, :create, :update, :delete]
  end
end
