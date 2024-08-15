class ApplicationsController < ApplicationController
  wrap_parameters exclude: [ :id ]
  def create
    @application = Application.new(application_params)

    if @application.save
      render json:  @application, except: [ :id ], status: :created

    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  def update
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
