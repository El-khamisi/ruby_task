class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::RoutingError, with: :route_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
  rescue_from Exception, with: :internal_server_error

  def record_not_found(exception)
    logger.error("Record not found [#{exception.model}]")

    render json: { error: "Record not found", message: exception.message }, status: :not_found
  end

  def route_not_found(exception)
    logger.error("Record not found [#{exception.model}]")

    render json: { error: "Route not found", message: exception.message }, status: :not_found
  end

  def internal_server_error (exception)
    logger.error("Internal Server Error: #{exception.message}")
    logger.error(exception.backtrace.join("\n"))

    render json: { error: "Internal server error", message: exception.message }, status: :internal_server_error
  end
end
