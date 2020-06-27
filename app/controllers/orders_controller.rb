class OrdersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  #Order(id: integer, client_id: integer, seller: integer, status: text, place: string, note: string, value: integer, created_at: datetime, updated_at: datetime)
  # OrderDetail(id: integer, order_id: integer, book_id: integer, quantity: integer, value: integer, created_at: datetime, updated_at: datetime)
  def index
    if user_signed_in?
      if current_user.typo.present? && current_user.typo == "worker"
        orden = Order.all
        detalles = OrderDetail.all
        @gente = User.all
        @locas = Location.all
      else
        orden = Order.where(user_id:current_user.id)
        if orden.present?
          detalles = OrderDetail.where(order_id:orden.ids)
          me = Message.where(user_id:2).last
          flash[$flash_status[me.view]] = me.body
        end
        @gente = User.all
        @locas = Location.all
      end #tipo
      if orden.present?
        @pagy, @orders =pagy_array( Utils.ordo(orden,detalles))
      else
        @pay,@orders = pagy_array([])
      end
    else
      @pay,@orders = pagy_array([])
    end
  end

  def new
    if current_user.name.blank?
      flash["info"]= "Primero debe completar el registro"
      redirect_to edit_profile_path(id:current_user.id)
    end
    inv = Inventory.all
    loca = Location.all
    bo = Book.all
    @inv = Utils.inventor(inv,loca,bo)
    @people = User.all
    @loca = Utils.loca_asigner(loca)
  end

  def show
    orden = Order.where(id:params[:id]).take
    detalles = OrderDetail.where(order_id:params[:id])
    gente = User.find(orden.user_id,orden.seller)
    locas = Location.where(id:orden.place)
    boo = Book.all
    @data = Utils.ordo_plus(orden,detalles,gente,locas, boo)
    @data = @data.first   if @data.present?
  end

  def create
    puts params
    ret = false
    detail = false
    if params["lines"].present?
      total = 0
      orden =  Order.new
      orden.status = params["status"]
      orden.user_id =  params["client_id"]
      orden.seller = params["seller"]
      orden.place = params["location"]
      orden.value = 0
      ret = orden.save
      params["lines"].each do |row|
        detail = OrderDetail.new
        detail.order_id = orden.id
        detail.book_id = row["book"]
        detail.quantity = row["quant"]
        total += row["value"].to_i
        detail.save if row["quant"].to_i > 0
      end
      orden.value = total
      orden.save
      Utils.messenger('Order creada','Order N°'+orden.id.to_s+" ha sido creada",orden.user_id,1)
      if ret.present? && detail.present?
        flash["success"] ="orden creada"
        redirect_to action: "show", id: orden.id
      else
        flash["danger"] ="error al crear"
        redirect_back(fallback_location: root_path)
      end
    else
      flash["warning"] ="faltan datos|"
      redirect_to action: "index"
    end
  end

  def edit
    orden = Order.where(id:params[:id]).take
    detalles = OrderDetail.where(order_id:params[:id])
    gente = User.find(orden.user_id,orden.seller)
    @loca = Location.where(id:orden.place)
    @data = Utils.ordo_plus(orden,detalles,gente,@loca)
    @data = @data.first   if @data.present?
  end

  def update
    if params["mini"].present?
      orden = Order.where(id:params[:id]).take
      orden.status = params["status"]
      te = orden.save
      if te
        if params["message"].present?
          Utils.messenger('Orden actualizada','orden n°'+params[:id]+': '+params["message"],orden.user_id,1)
        else
          Utils.messenger('Orden actualizada','orden n°'+params[:id],orden.user_id,2)
        end
        flash["success"] ="orden actualizada"
        redirect_to action: "show", id: orden.id
      else
        flash["warning"] ="error  al actualizar"
        redirect_to action: "index"
      end
    end


  end

  #of class
end
