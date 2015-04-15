class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)
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
  end

  def update
     @wiki = Wiki.find(params[:id])
     if @wiki.update_attributes(wiki_params)
       flash[:notice] = "Wiki was updated."
       redirect_to @wiki
     else
       flash[:error] = "There was an error saving the wiki. Please try again."
       render :edit
     end
   end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
