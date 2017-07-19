class ActivitiesController < ApplicationController

  def index
    @tag = params["Tag"]
    if @tag
      @activities = Activity.where(tag: @tag.downcase)

    elsif params["Category"]
      @activities = Activity.where(category: params["Category"])
    else
      @activities = Activity.where(['datetime >= ?', DateTime.now]).order(datetime: :asc)
    end
    @categories = Category.pluck(:name)
  end

  def new
    @user = current_user
    @activity = Activity.new
    @categories = Category.pluck(:name)
  end

  def create
    @activity = current_user.activities.new(activity_params)
    @user = current_user
    if @activity.save
      flash[:notice] = "Your activity has been posted! Good luck!"
      #ConfirmationMailer.confirm_activity(@activity, current_user).deliver_now 
    else
      flash[:notice] = @activity.errors.full_messages.to_sentence
    end
    redirect_to root_path
  end

  def show
    @activity = Activity.find(params[:id])
    @attendance = @activity.attendances.where(user_id: current_user.id).where(activity_id: @activity.id)[0]
    @people_needed = @activity.participants - @activity.active_participants
    @geojson = Array.new
    @geojson << {
      type: 'Feature',
      geometry: {
        type: 'Point',
        coordinates: [@activity.longitude, @activity.latitude]
      },
      properties: {
        :'marker-color' => '#FE5F55',
        :'marker-symbol' => 'circle',
        :'marker-size' => 'medium'
        }
    }
    respond_to do |format|
      format.html
      format.json { render json: @geojson }  # respond with the created JSON object
    end
  end

  def activity_params
    params.require(:activity).permit(:title, :description, :location, :participants, :datetime, :category, :tag, :latitude, :longitude)
  end

  def confirmation
    @user = current_user
    @activity = current_user.activities.new(activity_params)
    @categories = Category.pluck(:name)
  end

  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy
    redirect_to user_path(current_user)
  end
end
