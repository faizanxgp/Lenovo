defmodule LenovoWeb.AdminController do
  use LenovoWeb, :controller

  alias Lenovo.{UserManger.User, UserManger}


  def list_of_all_users(conn, _params ) do #index
    list_of_all_users = UserManger.list_users()
    case list_of_all_users do
      #case k sath likh rhe h list ko to Repo.all k case m [] list sab s phle likhe ge,
      # r Repo.one m [] list ki jgah nil, [] ni h to jo b h object m wo niche ajae ga.
      [] ->
        conn
        |> put_flash(:info, "No User Exists")
        |> render("list_of_all_users.html", list_of_all_users: list_of_all_users )
      list_of_all_users ->
        conn
        |> render("list_of_all_users.html", list_of_all_users: list_of_all_users)
    end

  end

  def show_a_user(conn, %{"id" => id}) do
    user = UserManger.get_user!(id)
    IO.inspect("a user")
    IO.inspect(user)
    render(conn, "show_a_user.html", user: user)
  end

  def edit_user(conn, %{"id" => id}) do
    user = UserManger.get_user!(id)
    changeset = UserManger.change_user(user)
    IO.inspect("changeset--------------")
    IO.inspect(changeset.data)
    render(conn, "edit_user.html", user: user, changeset: changeset)

  end
  def update_a_user(conn, %{"id" => id, "user" => user_params}) do
      IO.inspect "gggggggggggggg"
         IO.inspect user_params
    user = UserManger.get_user!(id)
    #user m struct arha h

    case UserManger.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User is successfully updated.!")
        |> redirect(to: "/admin")
      {:error, changeset} ->
        conn
        |> render("edit_user.html", user: user, changeset: changeset)
     end

  end
  def delete_a_user(conn, %{"id" => id}) do
    user = UserManger.get_user!(id)
    {:ok, _user} = UserManger.delete_user(user)
    conn
    |> put_flash(:info, "User deleted Successfully.")
    |> redirect(to: "/admin")
  end

end
