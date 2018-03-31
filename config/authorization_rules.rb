authorization do

  role :superadmin do
    description "+ Can assign other superadmin, admin, office, supervisor users"
    includes :admin
    has_permission_on [:high_access_user_roles], :to => [:assign]
  end

  role :admin do
    description "+ Can view markings value, can manage time sheets"
    includes :office
    includes :foreman
    has_permission_on [:private_time_sheets, :private_gun_sheets, :private_load_sheets], :to => :manage

    has_permission_on [:private_report_summaries], :to => [:all_job_value, :all_marking_value]
    has_permission_on [:private_job_estimates], to: [:manage, :collect_emails, :delete_document]
    has_permission_on [:jobs_value], :to => [:read]
    has_permission_on :private_equipments, :to => :add_note
  end

  role :office do
    description "+ Can view jobs value, can delete users"
    includes :crewman
    has_permission_on :private_reports, :to => :crew_time
    has_permission_on :private_reports, :to => :time_entries
    has_permission_on :private_reports, :to => [:accountant_csv, :user_time_csv]
    has_permission_on :private, :to => :settings
    has_permission_on :private_directory, :to => :index
    has_permission_on [:private_crews, :private_clients, :private_completions, :private_costs, :private_equipments,
                       :private_gun_marking_categories, :private_manufacturers, :private_materials, :users, :private,
                       :private_time_task_categories, :private_time_note_categories, :private_material_reports,
                       :private_material_report_summaries, :private_reconciliation_summaries, :private_report_summaries], :to => :manage
    has_permission_on :private_material_reports, :private_material_report_summaries, :to => [:update_dips, :print]
    has_permission_on [:private_clock_in, :private_clock_out, :private_time_sheets, :private_equipments], :to => [:create, :show, :delete_document]

    has_permission_on [:private_jobs, :private_job_sheets, :private_time_entries, :private_estimates], :to => [:manage, :delete_document, :archived_jobs]
    has_permission_on [:private_time_sheets, :private_gun_sheets, :private_load_sheets], :to => [:index, :read, :edit, :update, :destroy]
    has_permission_on [:jobs_value], :to => [:read]
    has_permission_on :private_crews, to: [:delete_job]
    has_permission_on [:private_jobs], :to => [:field_documents_download, :office_documents_download]
    has_permission_on [:private_gun_marking_categories], :to => [:hide, :hidden_list]

    has_permission_on :private_material_reports, :to => [:download_pdf]
    has_permission_on :private_equipments, :to => :add_note
  end

  role :supervisor do
    description "+ Can view all reports, manage crews, manage jobs, view all hours, export reports to CSV"
    includes :crewman
    has_permission_on :private_reports, :to => :crew_time
    has_permission_on :private_reports, :to => :time_entries
    has_permission_on :private_reports, :to => [:accountant_csv, :user_time_csv]
    has_permission_on :private, :to => :settings
    has_permission_on :private_directory, :to => :index
    has_permission_on [:private_time_sheets, :private_gun_sheets, :private_load_sheets,
                        :private_job_sheets, :private_time_entries, :private_estimates,
                       :private_clock_in, :private_clock_out, :private_time_sheets,
                       :private_clients, :private_completions, :private_costs, :private_equipments,
                       :private_gun_marking_categories, :private_manufacturers, :users, :private,
                       :private_time_task_categories, :private_time_note_categories, :private_directory, :private_report_summaries
                       ], :to => [:read]

    has_permission_on [:private_materials, :private_material_reports, :private_material_report_summaries, ], :to => [:manage, :update_dips, :print]
    has_permission_on [:private_crews, :private_jobs], :to => [:manage]

    # calendar related permissions
    has_permission_on :private_crews, to: [:show, :calendar, :delete_job]
    has_permission_on :api_crews, to: [:jobs, :schedule_job, :show_selected]

    has_permission_on [:private_jobs], :to => [:field_documents_download]
    has_permission_on [:private_gun_marking_categories], :to => [:hide, :hidden_list]

    has_permission_on :private_material_reports, :to => [:download_pdf]

    has_permission_on :private_equipments, :to => :add_note
  end

  role :foreman do
    description "+ Can view his crew's hours. Can clock in/clock out, create daily reports."
    includes :crewman
    has_permission_on :private_reports, :to => :crew_time
    has_permission_on [:private_clock_in, :private_clock_out, :private_time_sheets,
                       :private_load_sheets], :to => [:create, :show, :index]
    has_permission_on [:private_gun_sheets], :to => [:create, :show, :index, :edit, :update, :destroy]
    has_permission_on [:private_jobs], :to => [:show, :navigate]

    # calendar related permissions
    has_permission_on :private_crews, to: [:show, :calendar]
    has_permission_on :api_crews, to: [:jobs, :schedule_job, :show_selected]

    has_permission_on [:private_jobs], :to => [:field_documents_download]
    has_permission_on [:private_gun_marking_categories], :to => [:hide, :hidden_list]
    has_permission_on :private_equipments, :to => :add_note
  end

  role :crewman do
    description 'Can view jobs and add comments to them. Can view his own hours'
    has_permission_on :private, :to => [:index, :navigate]
    #has_permission_on :private_jobs, :to => :show
    has_permission_on :private_reports, :to => [:increase_offset, :decrease_offset, :reset_offset, :set_date]
    has_permission_on :private_reports, :to => :user_time
    has_permission_on :users, :to => :update do
      if_attribute :id => is { user.id }
    end
    has_permission_on :private_gun_sheets, :to => :print_selected
    has_permission_on :private_client_contacts, :to => :manage
    has_permission_on :private_comments, to: [:manage, :add_comment]
    has_permission_on :private_equipments, :to => :add_note
  end

  role :service_advisor do
    description 'Can view equipment. Can view his own hours'
    has_permission_on :private, :to => [:index, :navigate, :manage]
    has_permission_on :private_equipments, :to => :manage
    has_permission_on :users, :to => :update do
      if_attribute :id => is { user.id }
    end
    has_permission_on :private_equipments, :to => :add_note
  end

  role :parking_lot do
    description 'Can view Parking Lot Jobs'
    has_permission_on :private, :to => [:index, :navigate]
    has_permission_on [:private_jobs], :to => [:parking_lot_division]
    has_permission_on [:private_clock_in, :private_clock_out, :private_time_sheets] , :to => [:create, :show, :index]
    has_permission_on :private_jobs, :to => :show do
      if_attribute :parking_lot_division => is { true }
    end
    has_permission_on [:private_jobs], :to => [:manage]

    has_permission_on [:private_gun_sheets], :to => [:create, :show, :index, :edit, :update, :destroy]
    #has_permission_on :users, :to => [:index]

    has_permission_on :private_reports, :to => :user_time

    has_permission_on :private_crews, to: [:show, :update]

    has_permission_on :private_production_reports, to: [:manage, :read]
  end
end

privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end
