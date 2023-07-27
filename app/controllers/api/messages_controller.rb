class Api::MessagesController < ApplicationController
    def index
      @messages = Message.all
      render json: @messages
    end
  
    def create
        @message = Message.new(message_params)
        @message.timestamp = Time.zone.now # Set the timestamp to the current time
    
        # Replace 'YOUR_TWILIO_PHONE_NUMBER' with your Twilio phone number
        from_number = '+18449690523'
    
        to_number = params[:receiver]
        message_body = params[:content]
    
        account_sid = '' # Replace with your Twilio Account SID
        auth_token = ''   # Replace with your Twilio Auth Token
    
        @client = Twilio::REST::Client.new(account_sid, auth_token)
    
        begin
        # Use user-provided data for the Twilio message
        message = @client.messages.create(
            body: message_body,
            from: from_number,
            to: to_number
        )
    
        # If the Twilio message is sent successfully, save the local message object
        if @message.save
            render json: @message, status: :created
        else
            render json: { error: @message.errors.full_messages.join(', ') }, status: :unprocessable_entity
        end
        rescue Twilio::REST::RestError => e
        render json: { success: false, error: e.message }
        end
    end
    
  
    def destroy
      @message = Message.find(params[:id])
      @message.destroy
      head :no_content
    end
  
    private
  
    def message_params
        params.require(:message).permit(:content, :sender, :receiver, :timestamp, :session_id)
    end

    def messages_by_session
        session_id = params[:session_id]
        @messages = Message.where(session_id: session_id)
  
        render json: @messages
    end
end