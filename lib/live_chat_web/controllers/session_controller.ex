defmodule LiveChatWeb.SessionController do
  use LiveChatWeb, :controller
  alias LiveChat.Accounts


  def new(conn,_params) do
    render(conn, "new.html")

  end

  def create(conn, %{"session" => auth_params}) do
    user = Accounts.get_by_username(auth_params["username"])
    case Bcrypt.check_pass(user, auth_params["password"]) do
      {:ok, user} ->
        conn
        |> put_session(:current_user_id, user.id)
        |> put_flash(:info, "Signed In")
        |> redirect(to: Routes.page_path(conn, :index))
      {:error, _} ->
        conn
        |> put_flash(:info, "Enter password or username is wrong")
        |> render("new.html")
    end

  end

  def delete(conn, _params) do
    conn
    |> delete_session(:current_user_id)
    |> put_flash(:info, "Signed out successfully")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
