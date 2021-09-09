defmodule Lenovo.UserManger.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Argon2

  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string
    has_many :posts, Lenovo.UserPost.Post
    #has_many does not require anything to the DB. The foreign key of the associated schema Post,
    #is used to make the posts available from the user, allowing all posts for a given to user to be accessed via user.posts.


    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 5)
    |> put_password_hash()
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    IO.inspect "99999999999 changeset 999999999999999"
    IO.inspect changeset
    change(changeset, password: Argon2.hash_pwd_salt(password))
  end

  defp put_password_hash(changeset), do: changeset
end
