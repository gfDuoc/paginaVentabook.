class MessagesController < ApplicationController
  before_action :authenticate_user!
  # <Message id: nil, title: nil, body: nil, view: nil, user_id: nil, created_at: nil, updated_at: nil>

  def loader
    @mes = Message.where(user_id:current_user.id).last(4)
  end

  def index
    if current_user.typo == "worker"
      @pagy, @item = pagy_array(Message.all)
    else
      @pagy, @item = pagy_array(Message.where(user_id:current_user.id))
      @user = [user.find = item.map { |f| f.user_id }]
    end

  end

  def new
    @gente = User.all
  end

  def create
    ret = false
    m = Message.new
    m.title = params["title"]
    m.body = params["text"]
    m.view = params["status"]
    m.user_id = params["user_id"]
    ret = m.save
    if ret
      flash["success"] ="mensage creada"
      redirect_to controller:'messages', action: "index"
    else
      flash["danger"] ="error al crear"
      redirect_back(fallback_location: root_path)
    end
  end

  # of the class
end
