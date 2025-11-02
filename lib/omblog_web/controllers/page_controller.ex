defmodule OmblogWeb.PageController do
  use OmblogWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
