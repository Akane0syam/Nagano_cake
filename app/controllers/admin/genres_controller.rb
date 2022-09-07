class Admin::GenresController < ApplicationController
  def index
    @genres = Genre.all
    @genre = Genre.new
  end
  
  def create
    
  end
  
  def edit
    @genre = Genre.find(params[:id])
  end
  
  def update
  end
  
  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
