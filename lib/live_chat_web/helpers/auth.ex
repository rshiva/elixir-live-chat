defmodule LiveChatWeb.Helpers.Auth do
  alias LiveChat.Repo
  alias LiveChat.Accounts.User

  def signed_in?(conn) do
    user_id = Plug.Conn.get_session(conn, :current_user_id)
    if user_id, do: !!Repo.get(User, user_id)
  end

end
