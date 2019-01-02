class DirectMessagesController < ApplicationController 
	before_action :authenticate_user! 

	def show 
		users = [current_user, User.find(params[:id])]
		@chatroom = Chatroom.direct_messages.for(users)
	end

	def destroy 
	end
end