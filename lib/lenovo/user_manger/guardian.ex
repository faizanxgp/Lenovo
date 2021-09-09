defmodule Lenovo.UserManger.Guardian do
  use Guardian, otp_app: :lenovo

  alias Lenovo.UserManger

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    user = UserManger.get_user!(id)
    {:ok, user}
  rescue
    Ecto.NoResultsError -> {:error, :resource_not_found}
  end
#ab hme current user jo k login h us k against post add krna h to uski id chaiye ho gi.
#usko get krne k liye.......
#private ik map h us k andr guardian_default_claims: b ik map h us m sub pra h
def resource_from_claims(%{private: %{guardian_default_claims: %{"sub" => id}}}) do

    IO.inspect "vvvvvvvvvvvvvvvvvvvvv"
    IO.inspect id
    user = UserManger.get_user!(id)

    IO.inspect "vvvvvccccccccccccccccvvvvvvvvvvvvvvvv"
    IO.inspect user.id
    {:ok, user}
  rescue
    Ecto.NoResultsError -> {:error, :resource_not_found}
  end

  def resource_from_claims(conn) do
    # user = UserManager.get_user!(conn)
    # IO.inspect "vvvvvvvvvvvvvvvvvvvvv"
    # IO.inspect conn.sub
    # {:ok, user}
  # rescue
  #   Ecto.NoResultsError -> {:error, :resource_not_found}
  end
end
