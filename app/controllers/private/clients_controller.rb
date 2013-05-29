class Private::ClientsController < ApplicationController

  layout "private"
  filter_access_to :all

  def index
    @clients = Client.all.order('name ASC')
    @page_title = "Clients"
  end

  def new
    @client = Client.new
    @page_title = "New Client"
  end

  def create
    @client = Client.new(params[:client])
    @page_title = "New Client"
    if @client.save
      flash[:notice] = "Client created!"
      redirect_to private_clients_url
    else
      render :action => :new
    end
  end

  def edit
    @client = Client.find(params[:id])
    @page_title = "Edit #{@client.name}"
  end

  def update
    @client = Client.find(params[:id])
    if @client.update_attributes(params[:client])
      flash[:notice] = "Client updated!"
      redirect_to private_clients_url
    else
      render :action => :edit
    end
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    flash[:notice] = 'Client deleted!'
    redirect_to(private_clients_url)
  end

end
