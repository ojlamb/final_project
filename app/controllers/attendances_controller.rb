class AttendancesController < ApplicationController

  def index
    @activity = Activity.find(params[:activity_id])
    @people_needed = @activity.participants - @activity.active_participants
    render :'activities/show'
  end

  def create
    @activity = Activity.find(params[:activity_id])
    @attendance = Attendance.new(user_id: current_user.id, activity_id: @activity.id)
    if @activity.has_spaces?
      if @attendance.save
        @activity.update(active_participants: @activity.active_participants + 1)
        @people_needed = @activity.participants - @activity.active_participants
        render json: { new_people_count: @people_needed, notice: "You are SO in!" }
        #ConfirmationMailer.confirm_attendance(@activity, current_user).deliver_now
        #ConfirmationMailer.notify_of_attendance(@activity, @activity.user, current_user).deliver_now
      else
        render json: { notice: "You're already going to this activity - awesome!" }
      end
    else
      render json: { notice: "Sorry, this activity is full" }
    end
  end

  def destroy
    @attendance = Attendance.find(params[:id])
    @activity = Activity.find(@attendance.activity_id)
    @attendance.destroy
    @activity.update(active_participants: @activity.active_participants - 1)
    flash[:notice] = "You are no longer attending this activity"
    redirect_to root_path
  end


end
