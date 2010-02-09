class CareersController < ApplicationController

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
        flash[:notice] = 'Thank you for submitting your Employment Information.'
        format.html { redirect_to(@career) }
      else
        format.html { render :action => "new" }
      end
    end
  end

end
