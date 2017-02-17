class AttendancesController < ApplicationController
  def new
    @attendance = Attendance.new
    @big_logo_img = true
  end

  def create
    @attendance = Attendance.locate_code_and_phone attendance_params
    @big_logo_img = true

    respond_to do |format|
      if @attendance.save
        # Send a text message to user
        boot_twilio
        begin
          sms = @client.messages.create(
            from: Rails.application.secrets.twilio_number,
            to: @attendance.user.phone,
            body: "You're all set for today's event #{@attendance.event.name}. You received #{@attendance.points_awarded} points for attending this event.\nYour total community points is #{@attendance.user.total_points}. Visit http://plantains.care/ to manage your profile online."
          )
        rescue Twilio::REST::RequestError => e
          logs.warn e.message
        end
        format.html { redirect_to confirm_checkin_event_path(@attendance.event) }
        format.json { render :show, status: :created, location: @attendance }
      else
        format.html { render :new }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def boot_twilio
      account_sid = Rails.application.secrets.twilio_sid
      auth_token = Rails.application.secrets.twilio_token
      @client = Twilio::REST::Client.new account_sid, auth_token
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def attendance_params
      params.require(:attendance).permit(:user_phone, :event_code)
    end
end
