defmodule LitmusTest.PageController do
  use LitmusTest.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
