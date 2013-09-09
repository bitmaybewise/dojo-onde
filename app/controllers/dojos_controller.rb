# encoding: UTF-8

class DojosController < ApplicationController
  before_filter :require_login, only: [:new, :edit, :destroy]

  def new
    @dojo = Dojo.new
  end

  def create
    @dojo = Dojo.new(params[:dojo])
    if @dojo.save
      redirect_to @dojo, notice: 'Dojo cadastrado com sucesso.'
    else
      render action: :new
    end
  end

  def copied
    original = Dojo.find(params[:dojo_id])
    @dojo = Dojo.new({ 
              local: original.local, 
              info: original.info, 
              gmaps_link: original.gmaps_link 
            })
    render :new
  end

  def show
    @dojo = Dojo.includes(:user).find(params[:id])
  end

  def index
    @dojos = Dojo.not_happened
  end

  def happened
    @dojos = Dojo.happened
  end

  def edit
    @dojo = Dojo.find(params[:id])
  end

  def update
    @dojo = Dojo.find(params[:id])
    if @dojo.update_attributes(params[:dojo])
      redirect_to @dojo, notice: 'Dojo alterado com sucesso.'
    else 
      render :edit
    end
  end

  def participate
    @dojo = Dojo.find(params[:dojo_id])
    @dojo.include_participant!(current_user)
    redirect_to @dojo, notice: "Incluído na lista de participantes ;)"
  end

  def quit
    @dojo = Dojo.find(params[:dojo_id])
    @dojo.remove_participant!(current_user)
    redirect_to @dojo, notice: "Que pena que desistiu :("
  end

  def destroy
    @dojo = Dojo.find(params[:id])
    @dojo.destroy
    redirect_to :back, notice: "Dojo excluído com sucesso."
  end
end
