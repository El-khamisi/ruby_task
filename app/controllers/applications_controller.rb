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
    @application = Application.find_by!(token: params[:token])

    filtered_params = params.permit(:name)

    if @application.update(filtered_params)
      render json: @application, except: [ :id ], status: :ok
    else
      render json: @application.errors, status: :unprocessable_entity
    end
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
