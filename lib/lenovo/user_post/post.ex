defmodule Lenovo.UserPost.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "post" do
    field :body, :string
    field :header, :string
    belongs_to :user, Lenovo.UserManger.User

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
     # yha p user_id le ge ku k ye jo belongs_to jo h is m jo field de ge usk sath _id lga deta h khud s, jaisa k
    # yha :user h  to usko :user_id kr de ga .is liyee jha user.id likha h
    |> cast(attrs, [:header, :body, :user_id])
    |> validate_required([:header, :body])
  end
end
