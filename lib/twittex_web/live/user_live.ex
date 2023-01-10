defmodule TwittexWeb.UserLive do
  use TwittexWeb, :live_view

  alias Twittex.Accounts
  alias Twittex.Feed
  alias Twittex.Feed.Tweek
  import TwittexWeb.AvatarHelper

  on_mount {TwittexWeb.LiveAuth, :fetch_current_user}

  def mount(%{"username" => username}, _session, socket) do
    user = Accounts.get_user_by_username!(username)
    tweeks = Feed.list_tweeks_for_user(user)
    changeset = Feed.change_tweek(%Tweek{})
    {:ok, assign(socket, changeset: changeset, tweeks: tweeks, user: user)}
  end

  def handle_event("save", %{"tweek" => tweek_params}, socket) do
    current_user = socket.assigns.current_user

    if is_nil(current_user), do: raise "not logged in"

    case Feed.create_tweek_for_user(current_user, tweek_params) do
      {:ok, tweek} ->
        {:noreply, update(socket, :tweeks, & [tweek | &1])}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
  
end
