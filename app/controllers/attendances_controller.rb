class AttendancesController < ApplicationController
  def new
    @attendance = Attendance.new
  end

  def create
    @event = Event.find_by_code! attendance_params[:event_code]
    @user = User.find_or_create_by! phone: attendance_params[:user_phone]
    @attendance = Attendance.new event_id: @event.id,
                                 user_id: @user.id,
                                 points_awarded: @event.award_points

    respond_to do |format|
      if @attendance.save
        format.html { redirect_to @event, notice: 'attendance was successfully created.' }
        # TODO JSON Format
        # format.json { render :show, status: :created, location: @attendance }
      else
        format.html { render :new }
        # TODO JSON Format
        # format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    # TODO Find attendance record by event_id and user_id
    respond_to do |format|
      format.html { render :new, notice: 'Check-in was canceled.' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def attendance_params
      params.require(:attendance).permit(:user_phone, :event_code)
    end
end
