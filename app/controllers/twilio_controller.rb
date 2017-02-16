class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token
  # Enable this if Devise is used
  # skip_before_filter :authenticate_user!, :only => "reply"
  
  def voice
    response = Twilio::TwiML::Response.new do |r|
      r.Say "Hi! We're busy planting plantains. Call us back another time. Bye!", voice: "alice"
      r.Play "http://linode.rabasa.com/cantina.mp3"
    end
    render :xml => response.to_xml
  end

  def reply_text
    from_number = params["From"]
    boot_twilio
    sms = @client.messages.create(
      from: Rails.application.secrets.twilio_number,
      to: from_number,
      body: "Hello there, thanks for texting us. We're out busy planting plantains. One day we might be able to get back to you."
    )
  end

  private

    def boot_twilio
      account_sid = Rails.application.secrets.twilio_sid
      auth_token = Rails.application.secrets.twilio_token
      @client = Twilio::REST::Client.new account_sid, auth_token
    end
end
