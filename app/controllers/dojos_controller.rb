class DojosController < ApplicationController
  before_filter :require_login, only: [:new, :edit, :destroy]
  before_action :set_dojo, only: [:edit, :show, :update, :participate, 
                                  :quit, :copied, :destroy]

  def new
    @dojo = Dojo.new
  end

  def create
    @dojo = Dojo.new(dojo_params)
    if @dojo.save
      redirect_to @dojo, notice: 'Dojo cadastrado com sucesso.'
    else
      render action: :new
    end
  end

  def copied
    @dojo = Dojo.new(local: @dojo.local, 
                     info: @dojo.info, 
                     gmaps_link: @dojo.gmaps_link)
    render :new
  end

  def show; end

  def index
    @dojos = Dojo.not_happened
  end

  def happened
    @dojos = Dojo.happened
  end

  def edit; end

  def update
    if @dojo.update(dojo_params)
      redirect_to @dojo, notice: 'Dojo alterado com sucesso.'
    else 
      render :edit
    end
  end

  def participate
    @dojo.include_participant!(current_user)
    redirect_to @dojo, notice: "Incluído na lista de participantes ;)"
  end

  def quit
    @dojo.remove_participant!(current_user)
    redirect_to @dojo, notice: "Que pena que desistiu :("
  end

  def destroy
    @dojo.destroy
    redirect_to :back, notice: "Dojo excluído com sucesso."
  end

  private
  def dojo_params
    params.require(:dojo).permit(:day, :local, :gmaps_link, :info, :user_id)
  end

  def set_dojo
    @dojo = Dojo.includes(:user).find(params[:id])
  end
end
