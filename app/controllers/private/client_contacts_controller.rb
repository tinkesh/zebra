class Private::ClientContactsController < ApplicationController
  layout "private"
  filter_access_to :all

  def new
    @client_contact = Client.find(params[:client_id]).client_contacts.new
    @page_title = "New Contact for #{@client_contact.client.name}"
  end

  def create
    @client_contact = ClientContact.new(params[:client_contact])
    @page_title = "New Contact for #{@client_contact.client.name}"
    if @client_contact.save
      flash[:success] = "Contact created!"
      redirect_to private_client_path(@client_contact.client)
    else
      render :action => :new
    end
  end

  def edit
    @client_contact = ClientContact.find(params[:id])
    @page_title = "Edit #{@client_contact.name}"
    render :action => :new
  end

  def update
    @client_contact = ClientContact.find(params[:id])
    if @client_contact.update_attributes(params[:client_contact])
      flash[:notice] = "Client updated!"
      redirect_to private_client_path(@client_contact.client)
    else
      render :action => :edit
    end
  end

  def destroy
    @client_contact = ClientContact.find(params[:id])
    @client_contact.destroy
    flash[:notice] = 'Contact deleted'
    redirect_to private_client_path(@client_contact.client)
  end

end
