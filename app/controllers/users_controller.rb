class UsersController < ApplicationController
	before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_back_or_default account_url
    else
      render :action => :new
    end
  end
  
  def show
    user_from_current_user
    @listings = @user.listings
    @title = "Welcome #{@user.name}. This is your profile." 
  end

  def edit
    user_from_current_user
  end
  
  def update
    user_from_current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end

  def listings
    user_from_id
    @listings = @user.listings
  end


  private
  
  def user_from_current_user
    @user = @current_user
  end

  def user_from_id
    @user = User.find(params[:id])
  end
end
