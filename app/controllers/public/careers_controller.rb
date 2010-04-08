class Public::CareersController < ApplicationController

  layout "public"

  # GET /careers/new
  def new
    @career = Career.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /careers
  def create
    @career = Career.new(params[:career])

    respond_to do |format|
      if @career.save
        format.html { redirect_to thankyou_path }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def thankyou

  end


end
