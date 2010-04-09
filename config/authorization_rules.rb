authorization do

  role :admin do
    includes :office
    includes :foreman
    has_permission_on [:private_time_sheets, :private_gun_sheets, :private_load_sheets], :to => :manage
  end

  role :office do
    includes :crewman
    has_permission_on :private, :to => :settings
    has_permission_on [:private_clients, :private_completions, :private_costs, :private_equipments,
                       :private_gun_marking_categories, :private_manufacturers, :private_materials, :users, :private,
                       :private_time_task_categories, :private_time_note_categories], :to => :manage

    has_permission_on [:private_jobs, :private_job_sheets, :private_time_entries], :to => [:manage]
    has_permission_on [:private_time_sheets, :private_gun_sheets, :private_load_sheets], :to => :read
  end

  role :foreman do
    includes :crewman
    has_permission_on [:private_clock_in, :private_clock_out, :private_time_sheets,
                       :private_gun_sheets, :private_load_sheets], :to => [:create, :read]
    has_permission_on [:private_jobs], :to => [:read]
  end

  role :crewman do
    has_permission_on :private, :to => [:index, :navigate]
    has_permission_on :private_directory, :to => :index
    has_permission_on :private_job, :to => :show
  end
end

privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete, :revert]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end
