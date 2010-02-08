User.create(:login => 'dana.janssen', :password=> 'slicem3', :password_confirmation => 'slicem3', :email=> "dana@agilestyle.com")
Role.create(:name => 'admin')
Role.create(:name => 'user')
User.first.roles << Role.find_by_name("admin")