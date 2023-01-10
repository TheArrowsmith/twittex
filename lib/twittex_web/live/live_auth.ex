defmodule TwittexWeb.LiveAuth do
  import Phoenix.Component

  alias Twittex.Accounts

  def on_mount(:fetch_current_user, _params, session, socket) do
    {:cont, assign(socket, current_user: fetch_current_user(session))}
  end

  defp fetch_current_user(%{"user_token" => user_token}) do
    Accounts.get_user_by_session_token(user_token)
  end

  defp fetch_current_user(_session), do: nil
end
