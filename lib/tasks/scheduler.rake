task :check_for_black_and_red_flags => :environment do
  # This task runs daily. It checks all equipment and sends email alerts if necessary.
  Equipment.check_for_black_and_red_flags
end
