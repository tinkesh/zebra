authorization do
  role :guest do
    #has_permission_on :controller, :to => [:index, :show ]
  end

  role :admin do
    has_permission_on :users, :to => [:index, :show, :new, :create, :edit, :update, :destroy]
  end
end
