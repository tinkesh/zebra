authorization do
  role :guest do
    #has_permission_on :controller, :to => [:index, :show ]
  end

  role :admin do
    has_permission_on :private, :to => [:index, :settings, :navigate]
    has_permission_on [:users, :careers, :contacts, :clients], :to => [:index, :show, :new, :create, :edit, :update, :destroy]
    has_permission_on :private_directory, :to => :index
    has_permission_on :private_equipments, :to => :all
  end
end