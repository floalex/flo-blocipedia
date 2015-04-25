class WikisController < ApplicationController
  def index
    @wikis = Wiki.visible_to(current_user).paginate(page: params[:page], per_page: 10)
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

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
