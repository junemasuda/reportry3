class ReportsController < ApplicationController
  before_action :logged_in_user, only: [:create,]
  
  def index
    @q = Report.search(params[:q])
    @reports = @q.result
  end
  

  def show
    @report = Report.find(params[:id])
  end
  
  
  def create
    @report = current_user.reports.build(report_params)
    if @report.save
      flash[:success] = "Report created!"
      redirect_to root_url
    else
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc).page(params[:page]).per(10)# この行を追加
      render 'static_pages/home'
    end
  end
  
  
  def destroy
    @report = current_user.reports.find_by(id: params[:id])
    return redirect_to root_url if @report.nil?
    @report.destroy
    flash[:success] = "Report deleted"
    redirect_to request.referrer || root_url
  end
  
  private
  def report_params
    params.permit(:title, :artist, :content)
  end
end
