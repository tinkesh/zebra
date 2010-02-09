ActionController::Routing::Routes.draw do |map|

  map.resource :contacts, :only => [:new, :create], :path_names => { :new => '' }

  map.resource  :account, :controller => "users"
  map.resource  :user_session

  map.resources :password_resets
  map.resources :users

  map.login    'login',    :controller => "user_sessions", :action => "new"
  map.logout   'logout',   :controller => "user_sessions", :action => "destroy"

  map.register 'register', :controller => "users",         :action => "new"

  map.with_options :controller => "pages" do |page|
    page.about '/about', :action => 'about'
    page.equipment_for_sale "/equipment-for-sale", :action => "equipment_for_sale"
    page.products_mma_cold_plastic "/products/plastiroute-mma-cold-plastic", :action => "products_mma_cold_plastic"
    page.products_aquaplast "/products/plastiroute-aquaplast", :action => "products_aquaplast"
    page.products_cleanosol "/products/cleanosol-thermoplastic", :action => "products_cleanosol"
    page.products_glass_bead "/products/glass-bead", :action => "products_glass_bead"
    page.products "/products", :action => "products"
    page.remove_paint_on_a_car "/remove-paint-on-a-car", :action => "remove_paint_on_a_car"
    page.services '/services', :action => 'services'
    page.services_aggolmerate "/services/agglomerate", :action => "services_aggolmerate"
    page.services_aquaflex_intermix "/services/aquaflex-intermix", :action => "services_aquaflex_intermix"
    page.services_highway_beacon "/services/highway-beacon", :action => "services_highway_beacon"
    page.services_hot_thermoplastic "/services/hot-thermoplastic", :action => "services_hot_thermoplastic"
    page.services_line_painting "/services/line-painting", :action => "services_line_painting"
    page.services_line_removal "/services/line-removal", :action => "services_line_removal"
    page.services_mma_durables "/services/mma-durables", :action => "services_mma_durables"
    page.services_seal_coating "/services/seal-coating", :action => "services_seal_coating"
    page.services_fast_dry_paint "/services/fast-dry-paint-with-the-twin-dry-system", :action => "services_fast_dry_paint"
    page.services_parking_lot_maintenance "/services/parking-lot-maintenance", :action => "services_parking_lot_maintenance"
    page.suppliers '/suppliers', :action => 'suppliers'
    page.wet_night_aggolmerate "/services/wet-night-visibility/agglomerate-structured-marking", :action => "wet_night_aggolmerate"
    page.wet_night_dotflex "/services/wet-night-visibility/dotflex-mma-cold-plastic", :action => "wet_night_dotflex"
    page.wet_night_droponlinetm "/services/wet-night-visibility/droponlinetm-hot-thermoplastic", :action => "wet_night_droponlinetm"

  end

  map.root  :controller => "pages", :action => "home"

end