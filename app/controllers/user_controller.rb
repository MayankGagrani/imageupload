class UserController < ApplicationController
  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def update
    if current_user.update_attributes(user_params)
      redirect_to controller: :albums
    else
      @user = current_user
      render "user/edit"
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # Login
      session[:user_id] = @user.id
      redirect_to controller: :albums
    else
      render :new
    end
  end

  def login
    @user = User.new
    if request.post?
      # Authenticate user
      if !params[:user].blank?
        @user = User.authenticate(params[:user][:email], params[:user][:password])
        if @user
          session[:user_id] = @user.id
          redirect_to(controller: :albums)
        else
          flash[:notice] = "Invalid email/password combination"
        end
      end
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to login_users_path
  end

  private

   def user_params
     params.require(:user).permit(:name, :email, :password, :salt, :password_confirmation)
   end
end
