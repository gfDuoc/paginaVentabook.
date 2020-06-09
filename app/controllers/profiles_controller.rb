class ProfilesController < ApplicationController
  before_action :authenticate_user!
  def index
    if current_user.id !=1
        redirect_back(fallback_location: root_path)
    else
      @data = User.all
    end
  end
  def edit
      @data = User.find(params[:id])
  end

  def show
    @data = User.find(params[:id])
  end



  def update
    ret  = User.find(params[:id])
    ret.name = params[:name] if params[:name].present?
    ret.lastname = params[:lastname] if params[:lastname].present?
    if current_user.id
      ret.activate = params[:activate] if params[:activate].present?
      ret.typo = params[:typo] if params[:typo].present?
    end
    dato =  ret.save
    if dato.present?
      flash["success"] ="perfil actualizado"
      redirect_to action: "show", id: ret.id
    else
      flash["danger"] ="error actualizado"
      redirect_back(fallback_location: root_path)
    end
  end

end
