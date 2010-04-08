class Public::ContactsController < ApplicationController

  layout "public"

  # GET /contacts/new
  # GET /contacts/new.xml
  def new
    @contact = Contact.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /contacts
  # POST /contacts.xml
  def create
    @contact = Contact.new(params[:contact])

    respond_to do |format|
      if @contact.save
        flash[:notice] = 'Thank you for your contact submission.'
        format.html { redirect_to thankyou_path }
      else
        format.html { render :action => "new" }
      end
    end
  end

end
