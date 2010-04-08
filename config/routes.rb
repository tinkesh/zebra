ActionController::Routing::Routes.draw do |map|

  # public forms
  map.new_career     "careers",        :controller => "public/careers",  :action => "new"
  map.create_career  "careers/create", :controller => "public/careers",  :action => "create"
  map.new_contact    "contact",        :controller => "public/contacts", :action => "new"
  map.create_contact "contact/create", :controller => "public/contacts", :action => "create"

  # private forms
  map.namespace :private do |priv|
    priv.resources :clients,                :controller => "clients",                :path_prefix => "admin"
    priv.resources :costs,                  :controller => "costs",                  :path_prefix => "admin"
    priv.resources :equipments,             :controller => "equipments",             :path_prefix => "admin"
    priv.resources :manufacturers,          :controller => "manufacturers",          :path_prefix => "admin"
    priv.resources :materials,              :controller => "materials",              :path_prefix => "admin"
    priv.resources :completions,            :controller => "completions",            :path_prefix => "admin"
    priv.resources :jobs,                   :controller => "jobs",                   :path_prefix => "admin", :has_many => [:time_sheets, :gun_sheets, :job_sheets]
    priv.resources :job_sheets,             :controller => "job_sheets",             :path_prefix => "admin"
    priv.resources :time_sheets,            :controller => "time_sheets",            :path_prefix => "admin"
    priv.resources :time_note_categories,   :controller => "time_note_categories",   :path_prefix => "admin"
    priv.resources :time_task_categories,   :controller => "time_task_categories",   :path_prefix => "admin"
    priv.resources :load_sheets,            :controller => "load_sheets",            :path_prefix => "admin"
    priv.resources :gun_sheets,             :controller => "gun_sheets",             :path_prefix => "admin"
    priv.resources :gun_marking_categories, :controller => "gun_marking_categories", :path_prefix => "admin"

    # clocking in and out
    priv.connect "jobs/:job_id/clock_in/:action/:id",  :controller => "clock_in",  :path_prefix => "admin"
    priv.connect "jobs/:job_id/clock_out/:action/:id", :controller => "clock_out", :path_prefix => "admin"
#    priv.resources :time_tasks,             :controller => "time_tasks",           :path_prefix => "admin"
    priv.resources :time_entries,           :controller => "time_entries",         :path_prefix => "admin"
  end

  # user authentication and accounts
  map.resource  :user_session
  map.resources :password_resets
  map.resources :users, :path_prefix => "admin"

  map.revert_user "users/:id/revert/:version", :controller => "users", :action => "revert", :path_prefix => "admin"

  map.directory "directory", :controller => "private/directory", :action => "index", :path_prefix => "admin"
  map.register  "register",  :controller => "users",             :action => "new"
  map.login     "login",     :controller => "user_sessions",     :action => "new"
  map.logout    "logout",    :controller => "user_sessions",     :action => "destroy"

  # public content pages
  map.with_options :controller => "public" do |page|
    page.about                      "/about",                                 :action => "about"
    page.contacts_redirect          "/contacts",                              :action => "contacts_redirect"
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
    page.thankyou                   "/thankyou",                                 :action => "thankyou"
    page.wet_night_aggolmerate      "/services/wet-night-visibility/agglomerate-structured-marking", :action => "wet_night_aggolmerate"
    page.wet_night_dotflex          "/services/wet-night-visibility/dotflex-mma-cold-plastic",       :action => "wet_night_dotflex"
    page.wet_night_droponlinetm     "/services/wet-night-visibility/droponlinetm-hot-thermoplastic", :action => "wet_night_droponlinetm"
  end

  # private content pages
  map.with_options :controller => "private" do |page|
    page.private_home     "/admin",          :action => "index"
    page.private_settings "/admin/settings", :action => "settings"
    page.private_home     "/admin/navigate", :action => "navigate"
  end

  map.root  :controller => "public", :action => "home"

end
