class RetrospectivesController < ApplicationController
  before_action :require_login
  before_action :find_dojo

  def new
    @retrospective = @dojo.build_retrospective
  end

  def create
    @retrospective = @dojo.build_retrospective(retrospective_params)
    if @retrospective.save
      flash[:notice] = t('retrospectives.create.success')
      redirect_to @dojo
    else
      render :new
    end
  end

  def edit
    @retrospective = @dojo.retrospective
  end

  def update
    if @dojo.retrospective.update(retrospective_params)
      flash[:notice] = t('retrospectives.update.success')
      redirect_to @dojo
    else
      render :edit
    end
  end

  private
  def find_dojo
    @dojo = Dojo.find(params[:dojo_id])
  end

  def retrospective_params
    params.require(:retrospective).permit(:challenge, :positive_points, :improvement_points)
  end
end
