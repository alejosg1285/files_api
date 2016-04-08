class API::V1::DataFilesController < ApplicationController
  before_action :set_data_file, only: [:index, :show, :update, :destroy]

  # GET /api/v1/data_files
  def index
    @data_files = find_owner.data_files
    # @data_files = @user.data_files
  end

  # GET /api/v1/data_file/:id
  def show
  end

  # POST /api/v1/data_files
  def create
    @data_file = (find_owner) ? find_owner.data_files.build(data_file_params) : DataFile.new(data_file_params)
    # @data_file = DataFile.new(data_file_params)
    # @user.data_files << @data_file
    if @data_file.valid? and @data_file.save
      render json: {uri: api_v1_data_file_path(@data_file)}, status: :created
    else
      render json: {error: "error al ejecutar operacion", errors: @data_file.errors}, status: :unprocessable_entity
    end
  end

  # PUT /api/v1/data_file/:id
  def update
    if @data_file.update(data_file_params)
      render json: {uri: api_v1_data_file_path(@data_file)}, status: :ok
    else
      render json: {error: "error al ejecutar operacion", errors: @data_file.errors}, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/data_file/:id
  def destroy
    if @data_file.destroy
      render json: {status: :ok}, status: :ok
    else
      render json: {error: "Error al eliminar"}, status: :conflict
    end
  end

  # Disparadores de callbacks
  def set_data_file
    @data_file = DataFile.find(params[:id]) if params.has_key?(:id)
  end

  private

  def data_file_params
    if params.has_key?(:data_file)
      unless params[:data_file].blank?
        return params.require(:data_file).permit(:file, :description)
      end
    end
    fail "parametro 'data_file' vacio o inexistente"
  end

  def find_owner
    params.each do |key,value|
      if key =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    return nil?
  end

end
