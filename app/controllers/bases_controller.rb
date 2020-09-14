class BasesController < ApplicationController

  def new
    @base = Base.new
  end

  def create
    @base = Base.new(base_params)
    if @base.save
      flash[:success]="新たな拠点情報を追加しました"
      redirect_to bases_url
    else
      render :new 
  end  
      
  end

  def edit
  end

  def update
  end

  def index
    @bases = Base.all
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

