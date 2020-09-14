class BasesController < ApplicationController

  def new
    @base = Base.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def index
  end 

  def show
  end

  def destroy
  end




private

    def base_params
      params.require(:base).permit(:number, :name, :information)
    end
  end    

