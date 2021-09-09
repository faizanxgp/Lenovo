#ye m n authme s copy kiya tha, code jo chlane k liye, is liye aise bhr h.
#ye jo many to many k liye bridge table bnaaya tha us ki table to create kr liya tha migration s ,
#lakin schema rh gya tha wo automatically generate ni kiya m n .
defmodule Lenovo.Posts_tags do
    use Ecto.Schema
    import Ecto.Changeset

    schema "posts_tags" do
      field :post_id, :integer
      field :tag_id, :integer


    end


    @doc false
    def changeset(post_tags, attrs) do
      post_tags
      |> cast(attrs, [:post_id, :tag_id])
      |> validate_required([:post_id, :tag_id])
    end
  end
