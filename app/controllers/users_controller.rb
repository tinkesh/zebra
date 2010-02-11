class UsersController < ApplicationController

  layout "private"
  filter_resource_access
  
  def index
    @users = User.all
    @page_title = "All Users"
  end
  
  def new
    @user = User.new
    @page_title = "Create User Account"
  end
  
  def create
    @user = User.new(params[:user])
    params[:user][:role_ids] ||= []
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_back_or_default users_url
    else
      render :action => :new
    end
  end
  
  def show
    @user = current_user
    @page_title = "#{@user.first_name} #{@user.last_name} details"
  end

  def edit
    @user = User.find(params[:id])
    @page_title = "Edit #{@user.first_name} #{@user.last_name}"
  end
  
  def update
    params[:user][:role_ids] ||= []
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to users_url
    else
      render :action => :edit
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = 'User was deleted.'
    redirect_to(users_url)  
  end
  
end
