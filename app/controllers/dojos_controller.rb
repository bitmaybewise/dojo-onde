class DojosController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy, :participate]
  before_action :set_dojo, only: [:edit, :show, :update, :participate, :quit, :copied, :destroy]
  before_action :check_ownership, only: [:edit, :update, :destroy]

  def new
    @dojo = Dojo.new
  end

  def create
    @dojo = Dojo.new(dojo_params)
    @dojo.user = current_user

    if @dojo.save
      redirect_to @dojo, notice: t('dojos.create.success')
    else
      render :new
    end
  end

  def copied
    @dojo = Dojo.new(local: @dojo.local, info: @dojo.info, gmaps_link: @dojo.gmaps_link)
    render :new
  end

  def index
    @dojos = Dojo.not_happened.publishable
  end

  def happened
    @dojos = Dojo.happened
  end

  def update
    if @dojo.update(dojo_params)
      redirect_to @dojo, notice: t('dojos.update.success')
    else
      render :edit
    end
  end

  def participate
    begin
      @dojo.include_participant!(current_user)
      flash[:notice] = t('dojos.participate.success')
    rescue Dojoonde::ParticipantLimitError
      flash[:alert] = t('helpers.dojos.participate_button.participate_reached_limit')
    end

    redirect_to @dojo
  end

  def quit
    @dojo.remove_participant!(current_user)
    redirect_to @dojo, notice: t('dojos.quit.success')
  end

  def destroy
    @dojo.destroy
    redirect_to dojos_path, notice: t('dojos.destroy.success')
  end

  private
  def dojo_params
    params.require(:dojo).permit(:day, :local, :gmaps_link, :info, :private, :participant_limit)
  end

  def set_dojo
    @dojo = Dojo.includes(:user).find(params[:id])
  end

  def check_ownership
    unless current_user.can_manage?(@dojo.id)
      flash[:error] = t('dojos.check_ownership.edit.not_allowed')
      redirect_to @dojo
    end
  end
end
