class Private::JobEstimatesController < ApplicationController

  layout "private"
  filter_access_to :all

  def index
    @page_title = "Job Estimates"
    @job_estimates = JobEstimate.order('id desc')
  end

  def show
    @job_estimate = JobEstimate.find(params[:id])
    @page_title = "Show Job Estimate"
  end

  def new
    @job_estimate = JobEstimate.new
    @page_title = "New Job Estimate"
    @clients = Client.order(:name)
    @materials = Material.active.includes(:manufacturer)
  end

  def create
    @job_estimate = JobEstimate.new(params[:job_estimate])
    @page_title = "New Job Estimate"

    if @job_estimate.save
      if params[:save_and_send]
        @job_estimate.emails.split(',').each do |email|
          SiteMailer.delay.send_job_estimate_notice(@job_estimate, email)
        end
      end
      flash[:notice] = "Job Estimate created!"
      redirect_to private_job_estimates_path
    else
      @clients = Client.order(:name)
      @materials = Material.active.includes(:manufacturer)
      render action: :new
    end
  end

  def edit
    @job_estimate = JobEstimate.find(params[:id])
    @page_title = "Edit Job Estimate"
    @clients = Client.order(:name)
    @materials = Material.active.includes(:manufacturer)
  end

  def update
    @job_estimate = JobEstimate.find(params[:id])
    @page_title = "Edit Job Estimate"

    if @job_estimate.update_attributes(params[:job_estimate])
      if params[:save_and_send]
        @job_estimate.emails.split(',').each do |email|
          SiteMailer.delay.send_job_estimate_notice(@job_estimate, email)
        end
      end
      flash[:notice] = "Job Estimate updated!"
      redirect_to private_job_estimate_path(@job_estimate)
    else
      @clients = Client.order(:name)
      @materials = Material.active.includes(:manufacturer)
      render action: :edit
    end
  end

  def destroy
    @job_estimate = JobEstimate.find(params[:id])
    @job_estimate.destroy
    redirect_to private_job_estimates_path
  end

  def collect_emails
    client = Client.find_by_name(params[:client_name])
    emails = ''
    if client
      i = 0
      client.client_contacts.each do |contact|
        i += 1
        emails << ', ' unless i == 1
        emails << "#{contact.email}"
      end
    end

    puts emails

    respond_to do |format|
      format.json  {
        render json: { emails: emails}
      }
    end
  end

  def delete_document
    @job_estimate = JobEstimate.find(params[:id])
    document = @job_estimate.assets.find(params[:asset_id])
    document.destroy

    flash[:notice] = 'Document deleted!'
    redirect_to  private_job_estimate_path(@job_estimate)
  end
end
