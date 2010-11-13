module Private::ReconciliationSummariesHelper

  #-------------------------------------------------------------
  # Generates the link to the reconciliation summary or shows no gun sheets
  #
  def hlpRsummaries_reconciliation_summary_action_link(job)
    html = ""
    if job.gun_sheets.size == 0
      html = "No Gun Sheets"
    else
      html = link_to("Reconciliation Summary", private_reconciliation_summary_path(job))
    end
    html
  end

end
