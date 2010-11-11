module Private::ReconciliationSummariesHelper

  def hlpRsummaries_reconciliation_summary_action_link(job)
    html = ""
    if job.gun_sheets.size == 0
      html = "No Gun Sheets"
    else
      html = link_to("Reconciliation Summary", root_url)
    end
    html
  end

end
