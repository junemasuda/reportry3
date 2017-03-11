class ReportsController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :update]
  
  def index
      @q = Report.search(params[:q])
     #@q = Report.where(user_id: current_user.id).search(params[:q])
      @reports = @q.result
  end
  
  def show
    @report = Report.find(params[:id])
  end
  
  def create
    @report = current_user.reports.build(report_params)
 #   binding.pry
    if @report.save
      flash[:success] = "レポートが作成されました！！"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end
  
  def edit
    @report = Report.find(params[:id])
  end
  
  def update
    @report = Report.find(params[:id])
    if (current_user !=@user)
      redirect_to root_path
    end
    if @report.update
      redirect_to report_path(@report.id), notice:"保存できました！"
    else
      flash.now[:alert] = "保存に失敗しました・・・"
      render :edit
    end
  end
  
  def destroy
    @report = current_user.reports.find_by(id: params[:id])
    return redirect_to root_url if @report.nil?
    @report.destroy
    flash[:success] = "レポートを削除しました"
    redirect_to request.referrer || root_url
  end
  
  private
  def report_params
    params.require(:report).permit(:title, :artist, :content)
  end
end
