class Utils

  def self.inventor(inv,loca,book)
    #<Inventory id: nil, note: nil, quantity: nil, asked: nil, book_id: nil, location_id: nil, created_at: nil, updated_at: nil>
    #<Location id: nil, name: nil, stret: nil, created_at: nil, updated_at: nil>
    #<Book id: nil, name: nil, value: nil, created_at: nil, updated_at: nil>
    ret = false
    if book.present? && inv.present? && loca.present?
      ret = inv.all.as_json
      ret.each do |line|
        line["book_name"] = book.find(line["book_id"]).name
        line["value"] = book.find(line["book_id"]).value
        line["store"] = loca.find(line["location_id"]).name
        line["street"] = loca.find(line["location_id"]).stret
      end#each
    end #existen
    ret
  end

  def self.ordo(order,detail)
    # Order(id: integer, user_id: integer, seller: integer, status: text, place: string, note: string, value: integer, created_at: datetime, updated_at: datetime)
    #OrderDetail(id: integer, order_id: integer, book_id: integer, quantity: integer, value: integer, created_at: datetime, updated_at: datetime)
    ret = false
    if order.present? && detail.present?
      ret = []
      order.each do |ord|
        tempo = ord.as_json
        tempo["lines"]= []
        banana = detail.where(order_id:1)
        banana.each do|bana|
          tempo["lines"] << bana.as_json
        end#details
        ret << tempo
      end#orden
    end#existen
    ret
  end

  def self.ordo_plus(order,detail,gente,loca)
    # Order(id: integer, user_id: integer, seller: integer, status: text, place: string, note: string, value: integer, created_at: datetime, updated_at: datetime)
    #OrderDetail(id: integer, order_id: integer, book_id: integer, quantity: integer, value: integer, created_at: datetime, updated_at: datetime)
    ret = false
    if order.present? && detail.present? && gente.present? && loca.present?
      ret = []
      tempo = order.as_json
      tempo["lines"]= []
      detail.each do|bana|
        tempo["lines"] << bana.as_json
      end#details
      gente.each do |pepo|
        tempo["user_data"] = pepo.as_json if pepo.id == tempo["user_id"]
        tempo["seller_data"]= pepo.as_json if pepo.id == tempo["seller"]
      end
      tempo["location_data"] = loca.as_json
      ret << tempo
    end#existen
    ret
  end

  def self.loca_asigner(loca)
    ret = false
    if loca.present?
      loca = loca.as_json(only: [:id, :name])
      #loca << {"id"=>0,"name"=>"Domicilio"}
      ret = loca
    end
    ret
  end

  def self.messenger(title,avise,user,rare)
    ret = false
    m = Message.new
    m.title = title
    m.body = avise
    m.view = rare
    m.user_id = user
    ret = m.save
    ret
  end

  #of the class
end
