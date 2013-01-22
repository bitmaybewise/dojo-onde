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

  def show
    @dojo = Dojo.find(params[:id])
  end

  def index
    @dojos = Dojo.where("day >= ? ", Date.today).order("day DESC")
  end

  def happened
    @dojos = Dojo.where("day < ? ", Date.today).order("day DESC")
  end

  def edit
    @dojo = Dojo.find(params[:id])
  end

  def update
    @dojo = Dojo.find(params[:id])

    if @dojo.update_attributes(params[:dojo])
      redirect_to @dojo, notice: 'Dojo alterado com sucesso.'
    end
  end

  def destroy
    @dojo = Dojo.find(params[:id])
    @dojo.destroy
    redirect_to dojos_path
  end
end
