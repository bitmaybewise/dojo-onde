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
end
