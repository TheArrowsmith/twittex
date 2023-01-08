defmodule TwittexWeb.PageController do
  use TwittexWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
