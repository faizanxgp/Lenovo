defmodule LenovoWeb.Router do
  use LenovoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

 # Our pipeline implements "maybe" authenticated. We'll use the `:ensure_auth` below for when we need to make sure someone is logged in.
 pipeline :auth do
  plug Lenovo.UserManger.Pipeline
end

# We use ensure_auth to fail if there is no one logged in
pipeline :ensure_auth do
  plug Guardian.Plug.EnsureAuthenticated
end


  scope "/", LenovoWeb do
    pipe_through [:browser, :auth]

    get "/", PageController, :index
    get "/signin", SigninController, :signin
    post "/user_signin", SigninController, :user_signin
    get "/logout", SigninController, :logout
    get "/signup", SignupController, :signup
    post "/createaccount", SignupController, :createaccount
    get "/admin", AdminController, :list_of_all_users
    get "/admin/:id", AdminController, :show_a_user
    get "/admin/:id/edit", AdminController, :edit_user
    put  "/admin/:id", AdminController, :update_a_user
    delete "/admin/:id", AdminController, :delete_a_user
  end
  scope "/", LenovoWeb do
    pipe_through [:browser, :auth, :ensure_auth]
    get "/check", PageController, :check
    get "/adduserpost", PageController, :adduserpost #new
    post "createuserpost", PageController, :createuserpost #create
    get "/userpost/:id", PageController, :userpost  #show
    get "/userallposts", PageController, :userallposts  #index
    get "/edituserpost/:id/edit", PageController, :edituserpost #edit
    put "/edituserpost/:id", PageController, :updateuserpost #put,#update
    delete "/deleteuserpost/:id", PageController, :deleteuserpost #delete
    get "/tags", PageController, :tags
    post "/userspost", PageController, :posttags



  end

  # Other scopes may use custom stacks.
  # scope "/api", LenovoWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: LenovoWeb.Telemetry
    end
  end
end
