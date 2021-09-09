defmodule LenovoWeb.SignupController do
  use LenovoWeb, :controller

  alias Lenovo.{UserManger.User, UserManger}

  def signup(conn, _params) do
    changeset = UserManger.change_user(%User{})
    # changeset = User.changeset(%User{}, %{}) #same as above line
    IO.inspect ("======changeset======")
    IO.inspect (changeset)
    render(conn, "signup.html", changeset: changeset)
  end

  def createaccount(conn, %{"user" => user_params}) do
    IO.inspect ("======CONN======")
    IO.inspect (conn)

    case UserManger.create_user(user_params) do
      {:ok, user} ->
        IO.inspect("==========ok=============")
        IO.inspect (:ok)
        IO.inspect("==========user=============")
        IO.inspect (user)
        conn
        |> put_flash(:info, "Your account was created")
        |> redirect(to: "/")
      {:error, changeset} ->
        conn
        |> put_flash(:info, "Unable to create account")
        |> render("signup.html", changeset: changeset)
    end
  end
end
