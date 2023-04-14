defmodule TwittexWeb.UserSessionController do
  use TwittexWeb, :controller

  alias Twittex.Accounts
  alias TwittexWeb.UserAuth

  def new(conn, _params) do
    render(conn, :new, error_message: nil)
  end

  def create(conn, %{"user" => user_params}) do
    %{"email_or_username" => email_or_username, "password" => password} = user_params

    if user = Accounts.get_authenticated_user(email_or_username, password) do
      UserAuth.log_in_user(conn, user, user_params)
    else
      # In order to prevent user enumeration attacks, don't disclose whether the email or username is registered.
      render(conn, :new, error_message: "Invalid login")
    end
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "Logged out successfully.")
    |> UserAuth.log_out_user()
  end
end
