class API::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /api/v1/users

  def index
    @users = User.all
  end

  # GET /api/v1/user/:id

  def show

  end

  # POST /api/v1/users

  def create
    @user = User.new(user_params)
    # @user.data_files << @user.data_files.build(params[:user][:data_files])
    # @user.data_files << params[:user][:data_files].map { |file| DataFile.new(file: file.to_unsafe_h) } if params[:user].has_key?(:data_files) and !params[:user][:data_files].blank?
    if @user.valid? and @user.save
      render json: {uri: api_v1_user_path(@user)}, status: :created
    else
      render json: {error: "error al ejecutar operacion", errors: @user.errors}, status: :unprocessable_entity
    end
  end

  # PUT /api/v1/user/:id
  def update
    # @user.data_files << params[:user][:files].map { |file| DataFile.new(file: file) } if params[:user].has_key?(:files) and !params[:user][:files].blank?
    if @user.update(user_params)
      render json: {uri: api_v1_user_path(@user)}, status: :ok
    else
      render json: {error: "error al ejecutar operacion", errors: @user.errors}, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/user/:id

  def destroy
    if @user.destroy
      render json: {status: :ok}, status: :ok
    else
      render json: {error: "Error al eliminar"}, status: :conflict
    end
  end

  # Disparadores de callbacks
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    if params.has_key?(:user)
      unless params[:user].blank?
        return params.require(:user).permit(:name, :phone, :email, :avatar, data_files_attributes: [:id, :file, :description])
      end
    end
    fail "parametro 'user' vacio o inexistente"
  end

end
