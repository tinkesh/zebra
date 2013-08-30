class Private::DailyReportsController < ApplicationController
  include Wicked::Wizard

  layout 'private'
  before_filter :load_supporting_data
  before_filter :set_page_title

  steps :start, :paint, :finished

  def show
    render_wizard
  end

  def update
    @daily_report.update_attributes!(params[:daily_report])

    case step
    when :start
      if @daily_report.loaded?
        redirect_to new_private_load_sheet_path
      else
        redirect_to next_wizard_path
      end
    when :paint
      if @daily_report.painted?
        redirect_to new_private_gun_sheet_path
      else
        redirect_to next_wizard_path
      end
    when :finished
      redirect_to next_wizard_path
    else
    end
  end

  def finish_wizard_path
    new_private_time_sheet_path
  end


  private

  def load_supporting_data
    @daily_report = current_user.daily_report || DailyReport.create(:user_id => current_user.id)
    @load_sheets = @daily_report.load_sheets
    @gun_sheets = @daily_report.gun_sheets
  end

  def set_page_title
    # This will set the page title via the page_title helper in application_helper.rb
    @page_title = case step
    when :start
      'Daily Report'
    else
      'Daily Report'
    end
  end

end
