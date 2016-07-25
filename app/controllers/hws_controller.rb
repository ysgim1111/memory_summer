class HwsController < ApplicationController
    def _hws_header
        # 공지사항
        unless Hw.where(:writer => '고소왕').nil?
            @n=Hw.where(:writer => '고소왕')
        end
        # 내가 쓴 글
        unless Hw.where(:writer => :current_user.nickname).nil?
        @m = Hw.where(:writer => :current_user.nickname)
        end
        # 최근 댓글
        unless Hwscomment.nil?
        @r = Hwscomment.all
        end
        # 오늘의 사이다
        @a = []
        n = 0 
        Hw.all.each do |c|
            if (c.hwslikes.count.to_i-c.hwsunlikes.count.to_i) > 10
                @a[n] = c
                n = n+1
            end
        end
    end
    
    def create
            db=Hw.new
            db.user_id=current_user.id
            db.writer=current_user.nickname
            db.my_image=params[:image_file]
            db.secret=params[:secret]
            db.title=params[:title]
            db.content=params[:content]
            db.category=params[:category]
            db.save
            redirect_to "/hws/show/#{db.id}"    
    end
    def delete
        db=Hw.find(params[:id])
        db.destroy
        redirect_to '/hws/index'
    end
    def update
            db=Hw.find(params[:id])
            db.user_id=current_user.id
            db.writer=current_user.nickname
            db.my_image=params[:image_file]
            db.secret=params[:secret]
            db.title=params[:title]
            db.content=params[:content]
            db.category=params[:category]
            db.save
            redirect_to "/hws/show/#{params[:id]}"            
    end
    def createcomment
        db=Hwscomment.new
        db.user_id=current_user.id
        db.hw_id=params[:id]
        db.content=params[:content]
        db.writer=current_user.nickname
        db.save
        redirect_to "/hws/show/#{params[:id]}"
    end
    def deletecomment
        db=Hwscomment.find(params[:id])
        padb=db.hw_id
        db.destroy
        redirect_to "/hws/show/#{padb}"
    end
    def createsubcomment
        db=Hwssubcomment.new
        db.user_id=current_user.id
        db.hwscomment_id=params[:id]
        db.content=params[:content]
        db.writer=current_user.nickname
        db.save
        redirect_to "/hws/show/#{Hwscomment.find(params[:id]).hw_id}"
    end
    def deletesubcomment
        db=Hwssubcomment.find(params[:id])
        padb=db.hwscomment_id
        db.destroy
        redirect_to "/hws/show/#{Hwscomment.find(padb).hw_id}"
    end    
    def like
        #exist=Hw.find(params[:id]).hwspoints.where(:point => params[:point])
        #if exist==[]
            db=Hwslike.new
            db.hw_id=params[:id]
            db.point=params[:point]
            db.save        
            render :text => ""
        #end        
    end
    def unlike
        #exist=Hw.find(params[:id]).hwspoints.where(:minuspoint => params[:minuspoint])
        #if exist==[]
            db=Hwsunlike.new
            db.hw_id=params[:id]
            db.point=params[:point]
            db.save   
            render :text => ""
        #end        
    end        
#----------------------------------------------------------------------view related
    def show
        #뷰 카운트
        vc=Hwsview.new 
        vc.hw_id=params[:id]
        vc.viewcount=request.remote_ip
        vc.save
        #뎃뎃글 카운트
        @scc=0
        Hw.find(params[:id]).hwscomments.each do |n|
            @scc=@scc+n.hwssubcomments.count
        end
        #이전글 다음글 이어주기
        n=0
        a=[]
        Hw.all.each do |x|
            a[n]=x.id
            n=n+1
        end 
        @lowerbound=a[0]
        @upperbound=a[n-1]
        n=0
        a.each do |y|
            if y==params[:id].to_i
                @paafter=a[n-1]
                @pabefore=a[n+1]
            end
            n=n+1
        end
        #show의 목록부분
        n=0
        Hw.all.reverse.each do |x|
            if x.id==params[:id].to_i
               @page=(n/20).to_i+1
            end
            n=n+1
        end    
        n=0
        @a=[]        
        Hw.all.reverse.each do |x|
            if (n/20).to_i+1==@page
               @a.push(x)
            end
            n=n+1
        end
        @b=1.upto((n-1)/20+1)
        render layout: false
    end
    def index
        unless Hw.where(:writer => '고소왕').nil?
            @n=Hw.where(:writer => '고소왕')
        end
        n=0
        @a=[]
        if params[:id].nil?
            params[:id]=1
        end
        Hw.all.reverse.each do |x|
            if (n/20).to_i+1==params[:id].to_i
               @a.push(x) 
            end
            n=n+1
        end
        @b=1.upto((n-1)/20+1)
        render layout: false
    end
#-----------------------------------------------------------------------test    
    def tentime
        x=1.upto(140)
        x.each do |xx|
            db=Hw.new
            db.user_id=current_user.id            
            db.title="#{xx}번째 대량생산db"
            db.save
        end
        redirect_to '/hws/test'
    end
    def boom
        Hw.all.each do |x|
            x.destroy
        end
        redirect_to '/hws/test'
    end
    def test
        if params[:id].nil?
            page=1
        else
            page=params[:id].to_i 
        end
        @a=[]
        n=0
        Hw.all.reverse.each do |x|
            if ((n/4).to_i+1)==page
                @a.push(x)
            end
            n=n+1
        end
        b=1.upto((n-1)/4.to_i+1)
        @b=[]
        b.each do |y|
           @b.push("<a href='/hws/index/#{y}'>[#{y}]</a>") 
        end        
    end
    def edit
        render layout: false
    end
    def write
        render layout: false
    end
    
end
