class Api::V1::JobsController < ApplicationController
  def index
    begin
      @pagy, @jobs = pagy(Job.all.includes(:city, :company).order(created_at: :desc), page: safe_page_params)
      serialized_jobs = ActiveModelSerializers::SerializableResource.new(@jobs, each_serializer: JobSerializer).as_json
      render_success(serialized_jobs, pagy_metadata(@pagy))
    rescue StandardError => e
      render_error("Error occurred", :internal_server_error, [ e.message ])
    end
  end

  def show
    @job = Job.find(params[:id])
    serialized_job = ActiveModelSerializers::SerializableResource.new(@job, serializer: JobDetailSerializer).as_json
    render_success(serialized_job)
  end

  def create
    @job = Job.create(job_params)
    if job
      serialized_job = ActiveModelSerializers::SerializableResource.new(@job, serializer: JobDetailSerializer).as_json
      render_success(serialized_job, "You've created job successfully")
    else
      render_error("You've  failed created job", :unprocessable_entity, @job.errors.full_messages)
    end
  end

  private

  def job_params
    # Need to modify
    params.require(:users).permit(:title, :description, :salary, :industry_id, :company_id, :city_id, :user_id)
  end
end
