class MessagesController < ApplicationController
  before_action :authenticate_user!
  def loader
    @mes = Message.where(user_id:current_user.id).last(4)
  end

  def index
    @pagy, @item = pagy_array(Message.where(user_id:current_user.id))
  end

  def new
    @gente = User.all

  end

  def create
    ret = false
    m = Message.new
    m.title = title
    m.body = avise
    m.view = rare
    m.user_id = user
    ret = m.save
  end

# of the class
end
