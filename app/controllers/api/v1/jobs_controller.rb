class Api::V1::JobsController < ApplicationController
  def index
    begin
      @pagy, @jobs = pagy(Job.all.includes(:city, :company).order(created_at: :desc), page: safe_page_params)
      serialized_jobs = ActiveModelSerializers::SerializableResource.new(@jobs, each_serializer: JobSerializer).as_json
      render_success(data: serialized_jobs, meta: pagy_metadata(@pagy))
    rescue StandardError => e
      render_error("Error occurred", :internal_server_error, [ e.message ])
    end
  end

  def show
    @job = Job.find(params[:id])
    serialized_job = ActiveModelSerializers::SerializableResource.new(@job, serializer: JobDetailSerializer).as_json
    render_success(data: serialized_job)
  end

  def create
    @job = Job.new(job_params)
    @job.user_id = User.first.id
    if @job.save
      serialized_job = ActiveModelSerializers::SerializableResource.new(@job, serializer: JobDetailSerializer).as_json
      render_success(data: serialized_job, message: "You've created job successfully", status: :created)
    else
      render_error("Create job failed", :unprocessable_entity, @job.errors.full_messages)
    end
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :salary, :industry_id, :company_id, :city_id)
  end
end
