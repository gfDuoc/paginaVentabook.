class HomeController < ApplicationController
  def index
  end

  def letrock
    if Book.all.size == 0
      lo = Location.new( id: 0, name: "Domicilio", stret: "Dirrecion Cliente")
      lo.save
      lo = Location.new(name: "sede alameda", stret: "alameda")
      lo.save
      lo = Location.new(name: "sede antonio varas", stret: "antonio varas")
      lo.save
      lo = Location.new(name: "plaza norte", stret: "mall plaza")
      lo.save
      bo = Book.new(name: "el principito", value: 2000)
      bo.save
      bo = Book.new(name: "la divina comedia", value: 2000)
      bo.save
      bo = Book.new(name: "diccionario", value: 3000)
      bo.save
      bo = Book.new(name: "la razon de estar contigo", value: 7000)
      bo.save
      bo = Book.new(name: "libro negro del programador", value: 23000)
      bo.save
      bo = Book.new(name: "enciclopedia animal", value: 23000)
      bo.save
      bo = Book.new(name: "El Gran Libro De La Caca ", value: 21000)
      bo.save
      iv = Inventory.new(id: 1, note: "existe", quantity: 4, asked: 0, book_id: 1, location_id: 1)
      iv.save
      iv = Inventory.new(id: 2, note: "existe", quantity: 7, asked: 0, book_id: 2, location_id: 2)
      iv.save
      iv = Inventory.new(note: "existe", quantity: 2, asked: 0, book_id: 3, location_id: 3)
      iv.save
      iv = Inventory.new(note: "existe", quantity: 10, asked: 2, book_id: 4, location_id: 1)
      iv.save
      iv = Inventory.new(note: "existe", quantity: 10, asked: 2, book_id: 5, location_id: 3)
      iv.save
      iv = Inventory.new(note: "existe", quantity: 1, asked: 2, book_id: 6, location_id: 2)
      iv.save
      iv = Inventory.new(note: "existe", quantity: 11, asked: 0, book_id: 6, location_id: 3)
      iv.save
    end
    flash["success"] = "ready!!!"
    redirect_back(fallback_location: root_path)

  end
end
