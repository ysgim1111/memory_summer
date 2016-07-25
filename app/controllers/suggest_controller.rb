class SuggestController < ApplicationController
  
  def create
    db=Suggest.new
    db.user_id=current_user.id
    db.title=params[:title]
    if params[:you_nickname]
    db.you_nickname=params[:you_nickname]
    end
    db.you_email=params[:you_email]
    db.content=params[:content]
    db.category=params[:category]
    db.save
    flash[:notice] = "문의하신 사항이 접수되었습니다."
    redirect_to '/'
  end
end
