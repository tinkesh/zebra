ActionController::Routing::Routes.draw do |map|

  # public forms
  map.resource :careers,  :controller => "public/careers", :path_names => { :new => "" }
  map.resource :contacts, :controller => "public/contacts", :path_names => { :new => "" }

  # private forms
  map.namespace :private do |priv|
    priv.resources :clients,                :controller => "clients",                :path_prefix => "admin"
    priv.resources :costs,                  :controller => "costs",                  :path_prefix => "admin"
    priv.resources :equipments,             :controller => "equipments",             :path_prefix => "admin"
    priv.resources :manufacturers,          :controller => "manufacturers",          :path_prefix => "admin"
    priv.resources :materials,              :controller => "materials",              :path_prefix => "admin"
    priv.resources :completions,            :controller => "completions",            :path_prefix => "admin"
    priv.resources :jobs,                   :controller => "jobs",                   :path_prefix => "admin", :has_many => :time_sheets
    priv.resources :time_sheets,            :controller => "time_sheets",            :path_prefix => "admin"
    priv.resources :time_note_categories,   :controller => "time_note_categories",   :path_prefix => "admin"
    priv.resources :time_task_categories,   :controller => "time_task_categories",   :path_prefix => "admin"
    priv.resources :load_sheets,            :controller => "load_sheets",            :path_prefix => "admin"
    priv.resources :gun_sheets,             :controller => "gun_sheets",             :path_prefix => "admin"
    priv.resources :gun_marking_categories, :controller => "gun_marking_categories", :path_prefix => "admin"

#    priv.resources :time_tasks,             :controller => "time_tasks",           :path_prefix => "admin"
#    priv.resources :time_entries,           :controller => "time_entries",         :path_prefix => "admin"
  end

  # user authentication and accounts
  map.resource  :user_session
  map.resources :password_resets
  map.resources :users, :path_prefix => "admin"

  map.directory "directory", :controller => "private/directory", :action => "index", :path_prefix => "admin"
  map.register  "register",  :controller => "users",             :action => "new"
  map.login     "login",     :controller => "user_sessions",     :action => "new"
  map.logout    "logout",    :controller => "user_sessions",     :action => "destroy"

  # public content pages
  map.with_options :controller => "public" do |page|
    page.about                      "/about",                                 :action => "about"
    page.equipment_for_sale         "/equipment-for-sale",                    :action => "equipment_for_sale"
    page.products_mma_cold_plastic  "/products/plastiroute-mma-cold-plastic", :action => "products_mma_cold_plastic"
    page.products_aquaplast         "/products/plastiroute-aquaplast",        :action => "products_aquaplast"
    page.products_cleanosol         "/products/cleanosol-thermoplastic",      :action => "products_cleanosol"
    page.products_glass_bead        "/products/glass-bead",                   :action => "products_glass_bead"
    page.products                   "/products",                              :action => "products"
    page.remove_paint_on_a_car      "/remove-paint-on-a-car",                 :action => "remove_paint_on_a_car"
    page.services                   "/services",                              :action => "services"
    page.services_aggolmerate       "/services/agglomerate",                  :action => "services_aggolmerate"
    page.services_aquaflex_intermix "/services/aquaflex-intermix",            :action => "services_aquaflex_intermix"
    page.services_highway_beacon    "/services/highway-beacon",               :action => "services_highway_beacon"
    page.services_hot_thermoplastic "/services/hot-thermoplastic",            :action => "services_hot_thermoplastic"
    page.services_line_painting     "/services/line-painting",                :action => "services_line_painting"
    page.services_line_removal      "/services/line-removal",                 :action => "services_line_removal"
    page.services_mma_durables      "/services/mma-durables",                 :action => "services_mma_durables"
    page.services_seal_coating      "/services/seal-coating",                 :action => "services_seal_coating"
    page.services_parking_lot       "/services/parking-lot-maintenance",      :action => "services_parking_lot_maintenance"
    page.suppliers                  "/suppliers",                                                    :action => "suppliers"
    page.services_fast_dry_paint    "/services/fast-dry-paint-with-the-twin-dry-system",             :action => "services_fast_dry_paint"
    page.wet_night_aggolmerate      "/services/wet-night-visibility/agglomerate-structured-marking", :action => "wet_night_aggolmerate"
    page.wet_night_dotflex          "/services/wet-night-visibility/dotflex-mma-cold-plastic",       :action => "wet_night_dotflex"
    page.wet_night_droponlinetm     "/services/wet-night-visibility/droponlinetm-hot-thermoplastic", :action => "wet_night_droponlinetm"
  end

  # private content pages
  map.with_options :controller => "private" do |page|
    page.private_home      "/admin",          :action => "index"
    page.private_settings "/admin/settings", :action => "settings"
  end
  
  map.root  :controller => "public", :action => "home"

end
