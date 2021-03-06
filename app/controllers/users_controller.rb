class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def home
    puts "\n******** home ********"
    @user = User.new
  end

  def sign_in
    puts "\n******** sign_in ********"
    puts "params: #{params.inspect}"
    @user = User.where(:username => params[:user][:username], :password => params[:user][:password]).first
    session[:user_id] = @user[:id]
    puts "session[:user_id]: #{session[:user_id].to_i}"
    redirect_to user_posts_path(@user)
  end

  def sign_out
    session[:user_id] = nil
    redirect_to :home
  end

  def sign_up
      @user = User.create(user_params)
      flash[:notice] = "User Created! Please Login."
      redirect_to :sign_up

  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def current_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:fname, :lname, :email, :email_confirmation, :username, :password)
    end
end
