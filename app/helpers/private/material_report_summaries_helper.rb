module Private::MaterialReportSummariesHelper

  #-------------------------------------------------------------
  # Generates the link to the reconciliation summary or shows no gun sheets
  #
  def hlpRsummaries_material_report_summary_action_link(job)
    html = ""
    if (job.gun_sheets.size == 0) && (job.load_sheets.size == 0)
      html = "No Gun Sheets or load sheets"
    else
      html = link_to("Material Report Summary",  private_job_material_report_summary_path(job))
    end
    html
  end

end

