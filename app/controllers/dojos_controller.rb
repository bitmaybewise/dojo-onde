class DojosController < ApplicationController
  def new
    @dojo = Dojo.new
  end

  def create
    @dojo = Dojo.new(params[:dojo])
    if @dojo.save
      redirect_to @dojo, notice: 'Dojo cadastrado com sucesso.'
    end
  end

  def show
    @dojo = Dojo.find(params[:id])
  end

  def index
    @dojos = Dojo.all
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
    redirect_to dojos_url
  end
end
