class WikisController < ApplicationController
  def index
    @wikis = policy_scope(Wiki).paginate(page: params[:page])
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = current_user.wikis.build(wiki_params)
    @wiki.user = current_user
    authorize @wiki
    if @wiki.save
      flash[:sucess] = "Wiki was sucessfully saved!"
      redirect_to @wiki
    else
      flash[:error] = "Opps, an error occurred, please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    @collaborate_users = User.all.select { |user| user != current_user }
    @collaborators = @wiki.collaborate_users
    authorize @wiki
  end

  def update
     @wiki = Wiki.find(params[:id])
     authorize @wiki
     if @wiki.update_attributes(wiki_params)
       flash[:notice] = "Wiki was updated."
       redirect_to @wiki
     else
       flash[:error] = "There was an error saving the wiki. Please try again."
       render :show
     end
   end

   def destroy
      @wiki = Wiki.find(params[:id])
      authorize @wiki
      if @wiki.destroy
        flash[:notice] = "\"#{@wiki.title}\" was deleted sucessfully."
        redirect_to wikis_path
      else
        flash[:error] = "Unable to delte wiki, please try again."
        render :show
      end
    end

   def collaborators
     @wiki = Wiki.find(params[:id])
     @collaborators = @wiki.collaborators
     render 'collaborators/show_form'
   end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
