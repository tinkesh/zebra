class Private::ReportsController < ApplicationController

  layout "private"
  before_filter :load_user, :only => [:user_time]
  before_filter :load_crew, :only => [:crew_time]
  before_filter :kickout, :only => :user_time
  require 'csv'

  filter_access_to :all

  def user_time
    session[:report] = "user_time"
    session[:offset] ||= Time.zone.now
    @date = session[:offset]
    generate_front_to_back
    @entries = TimeEntry.where(:clock_in => @back.to_date...@front.to_date, :user_id => params[:id]).includes(:time_sheet => :estimates).order('clock_in ASC')
  end

  def crew_time
    session[:report] = "crew_time"
    session[:offset] ||= Time.zone.now
    @date = session[:offset]
    generate_front_to_back
    @users = @crew.users
  end

  def time_entries
    @page_title = "Recent Time Entries"
    session[:report] = "time_entries"
    session[:offset] ||= Time.zone.now
    @date = session[:offset]
    generate_front_to_back

    @entries = TimeEntry.where(:clock_in => @back.to_date...@front.to_date).includes(:user, {:time_sheet => :estimates}).order('clock_in ASC')
  end

  def set_date
    begin
      session[:offset] = Time.zone.parse(params[:date])
    rescue
    end
    url_params = {
      :action => session[:report]
    }
    url_params[:id] = params[:id] if params[:id].present? and params[:date].present?
    redirect_to url_params
  end

  def increase_offset
    session[:offset] ||= Time.zone.now
    session[:offset] += 1.months
    redirect_to :action => session[:report], :id => params[:id]
  end

  def decrease_offset
    session[:offset] ||= Time.zone.now
    session[:offset] -= 1.months
    redirect_to :action => session[:report], :id => params[:id]
  end

  def reset_offset
    session[:offset] = Time.zone.now
    url_params = {
      :action => session[:report]
    }
    url_params[:id] = params[:id] if params[:id].present?
    redirect_to url_params
  end

  def accountant_csv
    session[:offset] ||= Time.zone.now
    @date = session[:offset]
    generate_front_to_back

    csv_string = CSV.generate do |csv|
      csv << ["Name", "Rate", "Straight Time", "Over Time", "Per Diem", "Bank or Pay",
              "Less Advance", "Less 50% Benefits", "Direct Deposit", "SIN", "Start Date", "Notes"]
      @users = User.where(:employment_state => "Employed")
      @users.each do |u|
        @entries = TimeEntry.where(:clock_in => @back.to_date...@front.to_date, :user_id => u.id).includes(:time_sheet).order('clock_in ASC')
        if @entries
          straight_time = sprintf("%.2f", @entries.sum(&:straight_time))
          over_time     = sprintf("%.2f", @entries.sum(&:over_time))
          per_diem      = sprintf("%.2f", @entries.sum(&:per_diem_cost))
          u.bank_overtime_hours ? bank = "Bank" : bank = "Pay Out"
          csv << [u.name, u.rate, straight_time, over_time, per_diem, bank]
        else
          csv << [u.name, u.rate]
        end
      end
    end
    send_data(csv_string,
       :type => 'text/csv; charset=utf-8; header=present',
       :filename => "Payroll_#{@back}_to_#{@front}.csv")
  end

  def user_time_csv
    session[:offset] ||= Time.zone.now
    @date = session[:offset]
    generate_front_to_back

    csv_string = CSV.generate do |csv|
      csv << ["Name", "Rate", "Straight Time", "Over Time", "Per Diem",
              "Clock In", "Clock Out"]
      @user = User.find(params[:id])
      @entries = TimeEntry.where(:clock_in => @back.to_date...@front.to_date, :user_id => @user.id).includes([:time_sheet, :user]).order('clock_in ASC')
      if @entries
        @entries.each do |e|
          clock_in = e.clock_in.strftime('%Y-%m-%d %I:%M %p') if e.clock_in
          clock_out = e.clock_out.strftime('%Y-%m-%d %I:%M %p') if e.clock_out
          csv << [e.user.name, e.user.rate, e.straight_time, e.over_time, e.per_diem,
                  clock_in, clock_out]
        end
      end

    end
    send_data(csv_string,
       :type => 'text/csv; charset=utf-8; header=present',
       :filename => "#{@user.first_name}-#{@user.last_name}_#{@back}_to_#{@front}.csv")
  end

private

  def generate_front_to_back
    @date ||= Time.zone.now

    next_month = @date + 1.month
    last_month = @date - 1.month

    if @date.day <= 23
      @back = last_month.year.to_s + "-" + last_month.month.to_s + "-" + "24"
      @front = @date.year.to_s + "-" + @date.month.to_s + "-" + "24"
    else
      @back = @date.year.to_s + "-" + @date.month.to_s + "-" + "24"
      @front = next_month.year.to_s + "-" + next_month.month.to_s + "-" + "24"
    end
  end

  def load_user
    @user = User.find(params[:id])
  end

  def load_crew
    @crew = Crew.find(params[:id])

    allowed = false

    begin
      user_roles = current_user.roles.pluck(:name)
      allowed_roles = %w(admin superadmin office)
      return allowed = true unless (user_roles & allowed_roles).empty?
      return allowed = true if @crew.id.eql?(current_user.crew_id)
    rescue
    end

    if !allowed
      flash[:notice] = "You do not have permission to view the hours for this crew"
      redirect_to private_home_path
    end
  end

  def kickout
    unless params[:id] == current_user.id.to_s || current_user.role_symbols.include?(:admin) || current_user.role_symbols.include?(:office) || current_user.role_symbols.include?(:foreman)
      redirect_to private_home_path
    end
  end

end
