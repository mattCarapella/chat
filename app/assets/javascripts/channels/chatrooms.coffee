App.chatrooms = App.cable.subscriptions.create "ChatroomsChannel",
	connected: ->
		# Called when the subscription is ready for use on the server

	disconnected: ->
		# Called when the subscription has been terminated by the server

	received: (data) ->
		# Called when theres incoming data on the websocket for this channel
		active_chatroom = $("[data-behavior='messages'][data-chatroom-id='#{data.chatroom_id}']")
		
		if active_chatroom.length > 0
					
			if document.hidden 

				if $(".strike").length == 0 
					active_chatroom.append("<div class='strike'><span>Unread Messages</span></div>")

				if Notification.permission == "granted"
					new Notification(data.username, {body: data.body})
			
			else
				App.last_read.update(data.chatroom_id)

			
			active_chatroom.append("<li class='left'><div class='message-listitem'><div class='message-header'><span class='message-user'>#{data.username}</span></div><div class='message-body'><p>#{data.body}</p></div></div></li>")

			scroll()


		else
			$("[data-behavior='chatroom-link'][data-chatroom-id='#{data.chatroom_id}']").css("font-weight", "bolder").css("color", "#8500FF")

	send_message: (chatroom_id, message) -> 
		@perform "send_message", {chatroom_id: chatroom_id, body: message}

	scroll: () ->
		window.scrollTo(0, document.body.scrollHeight);
         