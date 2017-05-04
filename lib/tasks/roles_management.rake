namespace :roles do
  desc "Creating role"
  task :create, [:option] => [:environment] do |t, args|
    puts "create: #{args[:option]}"
    role = Role.find_by_name(args[:option])
    if role.blank?      
      new_role = Role.create(:name => args[:option])
      puts "Role created with id #{new_role.id}"
    else
      puts "Role #{args[:option]} already exists"
    end
  end

  desc "Deleting role"
  task :delete, [:option] => [:environment] do |t, args|
    puts "delete: #{args[:option]}"
    role = Role.find_by_name(args[:option])
    if !role.blank?
      users = role.users
      if users && users.count == 0
        role.delete
        puts "role deleted"
      else
        puts "cant delete the role as there are other users associated with this user"
      end

    else
      puts "role #{args[:option]} doesn't exists"
    end
  end
  
end
