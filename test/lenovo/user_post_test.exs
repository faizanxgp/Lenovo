defmodule Lenovo.UserPostTest do
  use Lenovo.DataCase

  alias Lenovo.UserPost

  describe "post" do
    alias Lenovo.UserPost.Post

    @valid_attrs %{body: "some body", header: "some header"}
    @update_attrs %{body: "some updated body", header: "some updated header"}
    @invalid_attrs %{body: nil, header: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> UserPost.create_post()

      post
    end

    test "list_post/0 returns all post" do
      post = post_fixture()
      assert UserPost.list_post() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert UserPost.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = UserPost.create_post(@valid_attrs)
      assert post.body == "some body"
      assert post.header == "some header"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserPost.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = UserPost.update_post(post, @update_attrs)
      assert post.body == "some updated body"
      assert post.header == "some updated header"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = UserPost.update_post(post, @invalid_attrs)
      assert post == UserPost.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = UserPost.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> UserPost.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = UserPost.change_post(post)
    end
  end
end
