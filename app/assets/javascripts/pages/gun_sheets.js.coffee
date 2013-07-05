jQuery ->
  jQuery('select#gun_sheet_job_id').on 'change', (event) ->
    job_id = jQuery(this).find(':selected').val()
    jQuery('#gun_marking_fields').load("/admin/jobs/#{job_id}/gun_sheets/new #gun_marking_fields")
