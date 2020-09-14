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
      flash[:danger] = "拠点情報を追加に失敗しました。" + @base.errors.full_messages.join("、")
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
    @base = Base.find(params[:id])
    if @base.destroy
      flash[:success]="拠点情報を消去しました"
      redirect_to bases_url
    else
    end 
  end




private

    def base_params
      params.require(:base).permit(:number, :name, :information)
    end
  end    

