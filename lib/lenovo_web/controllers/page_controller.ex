defmodule LenovoWeb.PageController do
  use LenovoWeb, :controller
  alias Lenovo.{UserManger.User, UserManger}
  alias Lenovo.{UserPost.Post, UserPost}
  alias Lenovo.{PostTag.Tag, PostTag}
  alias Lenovo.UserManger.Guardian
  alias Lenovo.Posts_tags
  import Ecto.Query

  def index(conn, _params) do
    render(conn, "index.html")
  end

  # def check(conn, _params) do
  #   user = Guardian.Plug.current_resource(conn)
  #   IO.inspect "--------------check user-------------"
  #   IO.inspect user

  #   render(conn,  "check.html", current_user: user)
  # end
  def adduserpost(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    IO.inspect "999999999999999999999999"
    IO.inspect conn
    render(conn, "adduserpost.html", current_user: user)
  end
  def createuserpost(conn, attrs ) do
    # IO.inspect "--------------user-id-------------"
    # IO.inspect Guardian.resource_from_claims(conn)

    case Guardian.resource_from_claims(conn) do


      {:ok, user} ->
        #yha p hm attrs m user ki id b de rhe h (attrs ik map h r us m new key,value enter kr rhe), :user_id ik key li r us m user.id uski value.
        attrs = Map.put(attrs, "user_id", user.id)
    case UserPost.create_post(attrs) do

      {:ok, post} ->
        IO.inspect("==========ok=============")
        IO.inspect (:ok)
        IO.inspect("==========post=============")
        IO.inspect (post)
        conn
        |> put_flash(:info, "Your Post is created")
        |> redirect(to: "/userallposts")
      {:error, changeset} ->
        conn
        |> put_flash(:info, "Unable to post")
        |> render("userpost.html", changeset: changeset)
    end
  {:error, user} ->
    conn |>
        put_flash(:info, "Error")
  end

end

def userpost(conn, %{"id" => id} = params) do #getsinglepost, show
      user = Guardian.Plug.current_resource(conn)

      IO.inspect "ffffffffffffffff"
      IO.inspect user
 #ye phle dono user p ik dosre ki post show kr rha tha, /userpost/3 hit krne p, to is chez s bchne k liye,
 #niche wali query likhi h.

 query = from p in Post, where: p.id == ^id and p.user_id == ^user.id
      IO.inspect "fffffffwwwwwwwwwwwwwwwwwwwwwwwfffffffff"
      IO.inspect query
      a =  Lenovo.Repo.one(query)
      IO.inspect "fffffffaaaaaaaaaaaaawwwwwwwwwwwwwwwwwwwwwwwfffffffff"
      IO.inspect a

     case a do
      nil -> conn |> put_flash(:info, "Nothing")|> redirect(to: "/")
      post -> render(conn, "userpost.html", post: post)
     end

    end

def userallposts(conn, _params) do
  user = Guardian.Plug.current_resource(conn)
  query = from u in User, where: u.id == ^user.id, preload: :posts
  IO.inspect "-----------------user-all-posts-query----------------"
  IO.inspect query
  user = Lenovo.Repo.one(query)
  IO.inspect "--------------user-all-posts-user-------------"
  IO.inspect user
  render(conn, "userallposts.html", posts: user.posts, user: user)
end

def edituserpost(conn, %{"id" => id}) do
  post = UserPost.get_post!(id)
  IO.inspect "------------edit------------------"
  IO.inspect(post)
  changeset = UserPost.change_post(post)
  IO.inspect "------------edit-changeset------------------"
  IO.inspect(changeset)

  render(conn, "edituserpost.html", post: post, changeset: changeset)
end

def updateuserpost(conn, %{"id" => id, "post" => post_params}) do
  post =  UserPost.get_post!(id)
  IO.inspect "------------update------------------"
  IO.inspect(post)
  a = UserPost.update_post(post, post_params)
  IO.inspect "------------update-a ------------------"
  IO.inspect(a)
  case a do
    {:ok, post} ->
      conn
      |> put_flash(:info, "you have successfully updated your post")
      |> redirect(to: "/userallposts")
    {:error, changeset} ->
      conn
      |> put_flash(:error, "cannot update the post")
      |> render("edituserpost.html", post: post, changeset: changeset)
  end

end
def deleteuserpost(conn, %{"id" => id}) do
  post = UserPost.get_post!(id)
  {:ok, _post} = UserPost.delete_post(post)
  conn
  |> put_flash(:info, "you have successfully deleted the post")
  |> redirect(to: "/userallposts")
end

def tags(conn, _) do
  user = Guardian.Plug.current_resource(conn)
  render(conn, "tags.html", current_user: user)
end

def posttags(conn, %{"post_id" => post_id, "name" => name} = attrs)  do
  IO.inspect("================nnnnnnnnnnnnnnnnnn=================")
IO.inspect attrs
  changeset = Tag.changeset(%Tag{}, attrs)
  {:ok, tag} = Lenovo.Repo.insert(changeset)
    IO.inspect tag
    IO.inspect ".........."

    IO.inspect tag.id
    tagg = Integer.to_string(tag.id)




  changeset2 = Posts_tags.changeset(%Posts_tags{}, Map.put(attrs, "tag_id", tagg))

  IO.inspect("================aaaaaaaaaaaaaaaaaaaa=================")
  IO.inspect changeset



  IO.inspect("================bbbbbbbbbbbb=================")
  IO.inspect changeset2

  case Lenovo.Repo.insert(changeset2) do
    {:ok, tag } ->
      conn

      |> put_flash(:info, "you have successfully added tags to the post")
      |> redirect(to: "/")
    {:error, changeset} ->
      conn
      |> put_flash(:info, "Unable to add tag to the post")
      |> render("", changeset: changeset)
  end
end




end
