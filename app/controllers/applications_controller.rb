class ApplicationsController < ApplicationController
  def create
    @application = Application.new(application_params)

    if @application.save
      render json:  @application, except: [ :id ], status: :created
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  def update
    Application.transaction do
      @application = Application.lock.find_by!(token: params[:token])
      @application.name = params[:name]

      @application.save!
    end

    render json: @application, except: [ :id ], status: :ok
  end

  def show
    @application = Application.find_by!(token: params[:token])
    render json: @application, except: [ :id ]
  end

  private
  def application_params
    { name: params.fetch(:name, "application #" "#{DateTime.now.strftime("%FT%R")}") }
  end
end
