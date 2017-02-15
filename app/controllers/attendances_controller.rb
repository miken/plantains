class AttendancesController < ApplicationController
  def new
    @attendance = Attendance.new
  end

  def create
    @attendance = Attendance.locate_code_and_phone attendance_params

    respond_to do |format|
      if @attendance.save
        format.html { redirect_to confirm_checkin_event_path(@attendance.event) }
        # TODO JSON Format
        # format.json { render :show, status: :created, location: @attendance }
      else
        format.html { render :new }
        # TODO JSON Format
        # format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def attendance_params
      params.require(:attendance).permit(:user_phone, :event_code)
    end
end
