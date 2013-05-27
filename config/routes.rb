AaaStriping::Application.routes.draw do
  # public forms
  match 'careers' => 'public/careers#new', :as => :new_career
  match 'careers/create' => 'public/careers#create', :as => :create_career
  match 'contact' => 'public/contacts#new', :as => :new_contact
  match 'contact/create' => 'public/contacts#create', :as => :create_contact

  # private forms
  namespace :private do
      resources :clients
      resources :completions
      resources :costs
      resources :crews
      resources :estimates
      resources :equipments
      resources :gun_sheets
      match 'private/gun_sheets/print_selected' => 'gun_sheets#print_selected', :as => :gun_sheets_print_selected, :path_prefix => 'admin'
      resources :gun_marking_categories
      resources :jobs
      match 'jobs/show_all/:id' => 'jobs#show_all', :as => :job_show_all, :path_prefix => 'admin'
      resources :job_sheets
      resources :load_sheets
      resources :manufacturers
      resources :material_reports
      resources :report_summaries, :only => [:index]
      resources :materials
      resources :time_sheets
      resources :time_note_categories
      resources :time_task_categories
      match 'archived_jobs' => 'jobs#archived_jobs', :as => :archived_jobs, :path_prefix => 'admin'
      match 'private/material_reports/:id/update_dips' => 'material_reports#update_dips', :as => :update_dips, :path_prefix => 'admin'
      match 'private/material_reports/:id/print' => 'material_reports#print', :as => :mat_print, :path_prefix => 'admin'

      # clocking in and out
      match 'clock_in/:action/:id' => 'clock_in#index', :path_prefix => 'admin'
      match 'clock_out/:action/:id' => 'clock_out#index', :path_prefix => 'admin'
      resources :time_entries
  end

  # reports
  match 'reports/increase_offset/:id' => 'private/reports#increase_offset', :as => :report_increase_offset, :path_prefix => 'admin'
  match 'reports/decrease_offset/:id' => 'private/reports#decrease_offset', :as => :report_decrease_offset, :path_prefix => 'admin'
  match 'reports/reset_offset/:id' => 'private/reports#reset_offset', :as => :report_reset_offset, :path_prefix => 'admin'
  match 'reports/user_time/:id' => 'private/reports#user_time', :as => :report_user_time, :path_prefix => 'admin'
  match 'reports/crew_time/:id' => 'private/reports#crew_time', :as => :report_crew_time, :path_prefix => 'admin'
  match 'reports/time_entries' => 'private/reports#time_entries', :as => :report_time_entries, :path_prefix => 'admin'
  match 'reports/accountant_csv' => 'private/reports#accountant_csv', :as => :export_accountant_csv, :path_prefix => 'admin'
  match 'reports/user_time_csv/:id' => 'private/reports#user_time_csv', :as => :export_user_time_csv, :path_prefix => 'admin'

  # summary reports
  match 'report_summaries/all_job_value' => 'private/report_summaries#all_job_value', :as => :all_job_value, :path_prefix => 'admin'
  match 'report_summaries/all_marking_value' => 'private/report_summaries#all_marking_value', :as => :all_marking_value, :path_prefix => 'admin'

  # versions
  match 'users/:id/revert/:version' => 'users#revert', :as => :revert_user, :path_prefix => 'admin'
  match 'jobs/:id/revert/:version' => 'private/jobs#revert', :as => :revert_job, :path_prefix => 'admin'
  match 'time_sheets/:id/revert/:version' => 'private/time_sheets#revert', :as => :revert_time_sheet, :path_prefix => 'admin'
  match 'load_sheets/:id/revert/:version' => 'private/load_sheets#revert', :as => :revert_load_sheet, :path_prefix => 'admin'
  match 'gun_sheets/:id/revert/:version' => 'private/gun_sheets#revert', :as => :revert_gun_sheet, :path_prefix => 'admin'

  # user authentication and accounts
  resource :user_session
  resources :password_resets
  resources :users

  match 'directory' => 'private/directory#index', :as => :directory, :path_prefix => 'admin'
  match 'register' => 'users#new', :as => :register
  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout

  # public content pages
  match '/about' => 'public#about', :as => :about
  match '/contacts' => 'public#contacts_redirect', :as => :contacts_redirect
  match '/equipment-for-sale' => 'public#equipment_for_sale', :as => :equipment_for_sale
  match '/products/plastiroute-mma-cold-plastic' => 'public#products_mma_cold_plastic', :as => :products_mma_cold_plastic
  match '/products/plastiroute-aquaplast' => 'public#products_aquaplast', :as => :products_aquaplast
  match '/products/cleanosol-thermoplastic' => 'public#products_cleanosol', :as => :products_cleanosol
  match '/products/glass-bead' => 'public#products_glass_bead', :as => :products_glass_bead
  match '/products' => 'public#products', :as => :products
  match '/remove-paint-on-a-car' => 'public#remove_paint_on_a_car', :as => :remove_paint_on_a_car
  match '/services' => 'public#services', :as => :services
  match '/services/agglomerate' => 'public#services_aggolmerate', :as => :services_aggolmerate
  match '/services/aquaflex-intermix' => 'public#services_aquaflex_intermix', :as => :services_aquaflex_intermix
  match '/services/highway-beacon' => 'public#services_highway_beacon', :as => :services_highway_beacon
  match '/services/hot-thermoplastic' => 'public#services_hot_thermoplastic', :as => :services_hot_thermoplastic
  match '/services/line-painting' => 'public#services_line_painting', :as => :services_line_painting
  match '/services/line-removal' => 'public#services_line_removal', :as => :services_line_removal
  match '/services/mma-durables' => 'public#services_mma_durables', :as => :services_mma_durables
  match '/services/seal-coating' => 'public#services_seal_coating', :as => :services_seal_coating
  match '/services/parking-lot-maintenance' => 'public#services_parking_lot_maintenance', :as => :services_parking_lot
  match '/suppliers' => 'public#suppliers', :as => :suppliers
  match '/services/fast-dry-paint-with-the-twin-dry-system' => 'public#services_fast_dry_paint', :as => :services_fast_dry_paint
  match '/thankyou' => 'public#thankyou', :as => :thankyou
  match '/services/wet-night-visibility/agglomerate-structured-marking' => 'public#wet_night_aggolmerate', :as => :wet_night_aggolmerate
  match '/services/wet-night-visibility/dotflex-mma-cold-plastic' => 'public#wet_night_dotflex', :as => :wet_night_dotflex
  match '/services/wet-night-visibility/droponlinetm-hot-thermoplastic' => 'public#wet_night_droponlinetm', :as => :wet_night_droponlinetm

  # private content pages
  match '/admin' => 'private#index', :as => :private_home
  match '/admin/settings' => 'private#settings', :as => :private_settings
  match '/admin/navigate' => 'private#navigate', :as => :private_navigate

  root :to => "public#home"
end
