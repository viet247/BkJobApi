class Api::V1::JobsController < ApplicationController
  def index
    begin
      # @pagy, @jobs = pagy(Job.all.includes(:city, :company))
      serialized_jobs = ActiveModelSerializers::SerializableResource.new(@jobs, each_serializer: JobSerializer).as_json
      render_success(serialized_jobs, pagy_metadata(@pagy))
    rescue StandardError => e
      render_error("Error occured", :internal_server_error, [e.message])
    end
  end
end
