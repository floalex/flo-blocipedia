class UsersController < ApplicationController
   before_action :authenticate_user!

 

  def show
    @user = User.find(params[:id])
    @wikis = @user.wikis
    
  end
 
   def update
     if current_user.update_attributes(user_params)
       flash[:notice] = "User information updated"
       redirect_to edit_user_registration_path
     else
       flash[:error] = "Invalid user information"
       redirect_to edit_user_registration_path
     end
   end
 
   private
 
   def user_params
     params.require(:user).permit(:name, :private)
   end
 end