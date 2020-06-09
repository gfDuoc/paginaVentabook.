class MessagesController < ApplicationController
  before_action :authenticate_user!
  def loader
    @mes = Message.where(user_id:current_user.id).last(4)
  end
end
