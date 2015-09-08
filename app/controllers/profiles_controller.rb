class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  respond_to :html

  def index
    @profiles = Profile.all
    respond_with(@profiles)
  end

  def show
    respond_with(@profile)
  end

  def new
    @profile = current_user.profiles.build
    respond_with(@profile)
  end

  def edit
  end

  def create
    @profile = current_user.profiles.build(profile_params)
    @profile.save
    respond_with(@profile)
  end

  def update
    @profile.update(profile_params)
    respond_with(@profile)
  end

  def destroy
    @profile.destroy
    respond_with(@profile)
  end

  private
    def set_profile
      @profile = Profile.find(params[:id])
    end

    def correct_user
      @profile = current_user.profiles.find_by(id: params[:id])
      redirect_to profiles_path, notice: "Not authorized to edit this pin" if @profile.nil?
    end

    def profile_params
      params.require(:profile).permit(:description)
    end
end
