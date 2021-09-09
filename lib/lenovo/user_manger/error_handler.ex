defmodule Lenovo.UserManger.ErrorHandler do
    import Plug.Conn
    use Phoenix.Controller

    @behaviour Guardian.Plug.ErrorHandler

    @impl Guardian.Plug.ErrorHandler
    def auth_error(conn, {type, _reason}, _opts) do
      IO.inspect("rrrrrrrrr")
      IO.inspect(type)
        conn
      |> put_flash(:info, "you don't have access to this page.")
      |> render(LenovoWeb.SignupView, "signup.html", changeset: :changeset)
      end

  end
