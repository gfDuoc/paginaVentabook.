class BooksController < ApplicationController
  # Book id: nil, name: nil, value: nil, created_at: nil, updated_at: nil
  def index
    @item = Book.all
  end

  def new
    @item = Book.new
  end

  def edit
    @item = Book.find(params[:id])
    redirect_to controller:'books', action: "index" if @item.blank
  end

  def create
    b = Book.new
    b.name = params[:name]
    b.value = params[:value]
    ret = b.save
    if ret
      flash["success"] ="libro  creado"
      redirect_to controller:'books', action: "index"
    else
      flash["danger"] ="error al crear"
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    b = Book.find(params[:id])
    b.name = params[:name]
    b.value = params[:value]
    ret = b.save
    if ret
      flash["success"] ="libro  creado"
      redirect_to controller:'books', action: "index"
    else
      flash["danger"] ="error al crear"
      redirect_back(fallback_location: root_path)
    end
  end

end
