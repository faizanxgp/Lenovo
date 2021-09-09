defmodule LenovoWeb.SigninController do
  use LenovoWeb, :controller
  alias Lenovo.{UserManger.User, UserManger, UserManger.Guardian}




def signin(conn, _params) do
  changeset = UserManger.change_user(%User{})
  maybe_user = Guardian.Plug.current_resource(conn)
  IO.inspect("------maybe-------------")
  IO.inspect(maybe_user)
  if maybe_user do
    redirect(conn, to: "/adduserpost")
  else
  render(conn, "signin.html", changeset: :user)
end
end

def user_signin(conn, %{"user" => %{"email" => email, "password" => password}}) do
  IO.inspect "-----------------------"
  IO.inspect "user"
  UserManger.authenticate_user(email, password)
  IO.inspect( "-------------user----------------")
  IO.inspect UserManger.authenticate_user(email, password)
  |> login_reply(conn)

end


defp login_reply({:ok, user}, conn) do
  IO.inspect( "-------------ok----user------11111111111111111111----------")
 conn
  |> put_flash(:info, "Welcome back!")
  |> Guardian.Plug.sign_in(user)   #This module's full name is Lenovo.UserManger.Guardian.Plug,
  |> IO.inspect()
  |> redirect(to: "/adduserpost")    #and the arguments specified in the Guardian.Plug.sign_in()
end                                #docs are not applicable here.

defp login_reply({:error, reason}, conn) do
  IO.inspect("cccccccccccccccccc")
  conn
  |> put_flash(:error, "user does not exist, kindly create account first")
  |> redirect(to: "/signup")
  end
def logout(conn, _) do
  conn
  |> Guardian.Plug.sign_out() #This module's full name is Auth.UserManager.Guardian.Plug,
  |> redirect(to: "/signin")   #and the arguments specfied in the Guardian.Plug.sign_out()
  end                           #docs are not applicable here

end
