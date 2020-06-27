class InventoriesController < ApplicationController
  #<Inventory id: nil, note: nil, quantity: nil, asked: nil, book_id: nil, location_id: nil, created_at: nil, updated_at: nil>

  def index
    @item = Inventory.all.as_json
    @book = Book.all
    @loca = Location.all
    if @item.present?
      @item.each do |line|
        b = @book.find(line["book_id"])
        l = @loca.find(line["location_id"])
        line["book_name"] = b.name if b.present?
        line["book_value"] = b.value if b.present?
        line["location_name"] = l.name if l.present?
      end
    end
  end

  def new
    @item = Inventory.new
    @book = Book.all
    @loca = Location.all
  end

  def edit
    @item = Inventory.find(params["id"])
      redirect_to controller: 'inventories', action: "index" if @item.blank?
    @book = Book.all
    @loca = Location.all
  end

  def create
    l = Inventory.new
    l.note = params[:note]
    l.quantity = params[:quantity]
    l.asked = 0
    l.book_id = params[:book_id]
    l.location_id = params[:location_id]
    ret = l.save
    if ret
      flash["success"] ="inventario agregado creada"
      redirect_to controller: 'inventories', action: "index"
    else
      flash["danger"] ="error al crear"
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    l = Inventory.find(params[:id])
    redirect_back(fallback_location: root_path) if l.blank?
    l.note = params[:note]
    l.quantity = params[:quantity]
    l.asked = params[:asked]
    l.book_id = params[:book_id]
    l.location_id = params[:location_id]
    ret = l.save
    if ret
      flash["success"] ="inventario actualizado"
      redirect_to controller: 'inventories', action: "index"
    else
      flash["danger"] ="error al Actualizar"
      redirect_back(fallback_location: root_path)
    end
  end

end
