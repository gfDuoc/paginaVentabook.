class LocationsController < ApplicationController

 def index
   @item = Location.all
 end

def new
  @item = Location.new
end

def edit
    @item = Location.find(params["id"])
    redirect_to controller:'locations', action: "index" if @item.blank?
end

def create
  l = Location.new
  l.name = params[:name]
  l.stret = params[:stret]
  ret = l.save
  if ret
    flash["success"] ="locaciones creada"
    redirect_to controller:'locations', action: "index"
  else
    flash["danger"] ="error al crear"
    redirect_back(fallback_location: root_path)
  end
end

end
