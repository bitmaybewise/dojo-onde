class RetrospectivesController < ApplicationController
  before_filter :find_dojo

  def new
    @retrospective = @dojo.build_retrospective
  end

  def create
    @retrospective = @dojo.build_retrospective(params[:retrospective])
    if @retrospective.save
      flash[:notice] = "Retrospectiva registrada."
      redirect_to @dojo
    else
      render :new
    end
  end

  def edit
    @retrospective = @dojo.retrospective
  end

  def update
    if @dojo.retrospective.update_attributes(params[:retrospective])
      flash[:notice] = "Retrospectiva atualizada."
      redirect_to @dojo
    else
      render :edit
    end
  end

  private
  def find_dojo
    @dojo = Dojo.find(params[:dojo_id])
  end
end
