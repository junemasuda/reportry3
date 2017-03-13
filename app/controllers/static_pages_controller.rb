class StaticPagesController < ApplicationController
  def home
      @reports = Report.all
  end
end
