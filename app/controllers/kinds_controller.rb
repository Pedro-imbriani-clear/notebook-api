class KindsController < ApplicationController
  before_action :set_kind, only: [:show, :update, :destroy]

  # include ActionController::HttpAuthentication::Basic::ControllerMethods
  # http_basic_authenticate_with name: "Pedro", password: "123456"

  include ActionController::HttpAuthentication::Digest::ControllerMethods
  USERS = { "Pedro" => Digest::MD5.hexdigest(["Pedro","Application","123456"].join(":"))}

  before_action :authenticate

  # GET /kinds
  def index
    @kinds = Kind.all

    render json: @kinds
  end

  # GET /kinds/1
  def show
    render json: @kind
  end

  # POST /kinds
  def create
    @kind = Kind.new(kind_params)

    if @kind.save
      render json: @kind, status: :created, location: @kind
    else
      render json: @kind.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /kinds/1
  def update
    if @kind.update(kind_params)
      render json: @kind
    else
      render json: @kind.errors, status: :unprocessable_entity
    end
  end

  # DELETE /kinds/1
  def destroy
    @kind.destroy
  end

  private

  def set_kind
    if params[:contact_id]
      @kind = Contact.find(params[:contact_id]).kind
      return @kind
    end
      @kind = Kind.find(params[:id])
  end

  def authenticate
    authenticate_or_request_with_http_digest('Application') do |username|
      USERS[username]
    end
  end

  def kind_params
    params.require(:kind).permit(:description)
  end
end
