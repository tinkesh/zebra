class PagesController < ApplicationController
  
  def home
    @page_title = 'aaastriping.ca'
  end
  
  def css_test
    @page_title = "CSS Test"
  end
  
end
