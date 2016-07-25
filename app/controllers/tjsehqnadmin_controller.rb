class TjsehqnadminController < ApplicationController
  before_filter :require_permission
  def index
    @dbdb = User.all
    render layout: false
  end
  
  def destroy
    one_receive = Receive.find(params[:id])
    one_receive.destroy
    redirect_to '/tjsehqnadmin/gosomi' 
  end
  
  def show
    render layout: false
  end
  def suggest
    @suggest = Suggest.all.paginate(:page => params[:page], :per_page => 30)
  end
  
  
  def gosomi
    @receive = Receive.all.paginate(:page => params[:page], :per_page => 30)
  end
  
  def information
      if params[:id].nil?
          params[:id]=1
      end
      #여기서부터 검색 엔진 및 카테고리 분류
      @a=[]
      n=0
      if params[:search]
          if Sueform.where("my_name LIKE ?", "%#{params[:search]}%").present?
              Sueform.where("my_name LIKE ?", "%#{params[:search]}%").reverse.each do |x|
                  if ((n/20).to_i+1)==params[:id].to_i
                          @a.push(x)
                  end
                      n=n+1
              end
          end    
      elsif params[:category]
          Sueform.where(:law_kind => params[:category]).reverse.each do |x|
              if ((n/20).to_i+1)==params[:id].to_i
                      @a.push(x)
              end
                  n=n+1
          end
      elsif
          Sueform.all.reverse.each do |x|
              if ((n/20).to_i+1)==params[:id].to_i
                  @a.push(x)
              end
              n=n+1
          end
      end
      @b=1.upto((n-1)/20+1)
      render layout: false
    
  end
  
  private
    def require_permission
    
      if current_user.check != 1
        redirect_to root_path
        
        #Or do something else here
      end
    end
  
end
