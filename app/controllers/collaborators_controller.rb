class CollaboratorsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_wiki_user

  def index
    @collaborators = @wiki.collaborators
  end

  def create
     @wiki.collaborators.create user: User.find_by(email: params[:email])
     redirect_to wiki_path(@wiki)
  end

  def destroy
    @collaborate_user = Collaborator.find(params[:id])
    if @collaborate_user.destroy
        flash[:notice] = "Collaborator removed"
        redirect_to wiki_path(@wiki)
      else
        flash[:error] = "There was an error. Please try again."
        redirect_to edit_wiki_path(@wiki)
      end
  end

  def find_wiki_user
    @wiki = Wiki.find(params[:wiki_id])
  end
end
