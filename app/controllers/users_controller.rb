class UsersController < ApplicationController
	before_action :set_user, only: [:show,:avatar]
	require "google/cloud/vision"
	def avatar
    content = @user.avatar.read
    if stale?(etag: content, public: true)
      send_data content, type: @user.avatar.file.content_type, disposition: "inline"
      expires_in 0, public: true
    end
  end

  def index
  	@users = User.all
  end
  
  def new
  	@user = User.new
  end

  def create
  	project_id = "stvision-196806"
		vision = Google::Cloud::Vision.new project: project_id
		image = vision.image params[:user][:avatar].tempfile
		image.context.languages = ["en"]
		text = image.text

  	@user = User.new(user_params)
  	@user.text = text
  	respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'image was successfully uploaded.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end	

  def show	

  end

  private
    def user_params
      params.require(:user).permit(:avatar, :text)
    end

    def set_user
    	@user = User.find(params[:id])
  	end
end
