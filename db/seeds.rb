User.create(:login => 'dana.janssen', :password=> 'foobar', :password_confirmation => 'foobar', :email=> "dana@agilestyle.com")
Role.create(:name => 'admin')
Role.create(:name => 'user')
User.first.roles << Role.find_by_name("admin")