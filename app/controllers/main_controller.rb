class MainController < ApplicationController


    def index_test
        
        
         @h = Hash.new
        uri = URI("https://search.naver.com/search.naver?sm=tab_hty.top&where=news&ie=utf8&query=%EC%95%85%ED%94%8C")
        page = Nokogiri::HTML(Net::HTTP.get(uri))
        page.xpath('//ul[@class="type01"]/li/dl/dt/a''[@href]').take(5).each do |link|
        @h[link.text.strip] = link['href']
        end
        if current_user.present?
        @c = Receive.where(:user_id => current_user.id)
        end
        a = Receive.take(10)
        @b = []
        a.reverse.each do |nick|
            if nick.you_nickname.to_s.length <= 3
                @b.push(nick.you_nickname[0..1] + "*"*(nick.you_nickname.to_s.length-2))
            elsif nick.you_nickname.to_s.length <= 6
                @b.push(nick.you_nickname[0..2] + "*"*(nick.you_nickname.to_s.length-3))
            elsif nick.you_nickname.to_s.length <= 15
                @b.push(nick.you_nickname[0..5] + "*"*(nick.you_nickname.to_s.length-6))
            end    
        end
        @n = 1
        @celebrities = Celebrity.all.order("count DESC").limit(10)
        @receives = Receive.all.order("created_at DESC").limit(10)
        
    end
    def index
        @h = Hash.new
        uri = URI("https://search.naver.com/search.naver?sm=tab_hty.top&where=news&ie=utf8&query=%EC%95%85%ED%94%8C")
        page = Nokogiri::HTML(Net::HTTP.get(uri))
        page.xpath('//ul[@class="type01"]/li/dl/dt/a''[@href]').take(5).each do |link|
        @h[link.text.strip] = link['href']
        end
        if current_user.present?
        @c = Receive.where(:user_id => current_user.id)
        end
        @n = 1
        @celebrities = Celebrity.all.order("count DESC").limit(10)
        @receives = Receive.all.order("created_at DESC").limit(10)
        
        #네이버 블로그 api 예시 post 방식
=begin        require "net/https"       
        require "uri"
         
        client_id = "YOUR_CLIENT_ID"
        client_secret = "YOUR_CLIENT_SECRET"
        url = "https://openapi.naver.com/v1/labs/translate.json"
        
        uri = URI.parse(url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
        
        request = Net::HTTP::Post.new(uri.request_uri)
        request.initialize_http_header({"X-Naver-Client-Id"=>client_id, "X-Naver-Client-Secret"=> client_secret})
        response = http.request(request)
        #네이버 블로그 api 예시 post 방식 끝
=end        
    end
    
    
    def warmheart
        if params[:id].nil?
            params[:id]=1
        end
        @receives=[]
        n=0
        Receive.all.reverse.each do |x|
                if ((n/20).to_i+1)==params[:id].to_i
                    @receives.push(x)
                end
                n=n+1
        end        
        @b=1.upto((n-1)/20+1)    
    end
    
    
    def mypage
     #  @p = Post.where(:user_id => current_user.id)
        @s = Sueform.where(:user_id => current_user.id)
        @r = Receive.where(:user_id => current_user.id)
        #level계산
    #    fincal=0
    #    cal1=User.find(current_user.id).posts
    #    cal1.each do |x|
    #    subcal=x.points.count
    #    fincal=fincal+subcal
    #    end
    #    dbdb=User.find(current_user.id)
    #    dbdb.level=fincal
    #    dbdb.save                
    end
    def mypage_test
    #    @p = Post.where(:user_id => current_user.id)
        @s = Sueform.where(:user_id => current_user.id)
        @q = Qna.where(:user_id => current_user.id)
        #level계산
    #    fincal=0
    #    cal1=User.find(current_user.id).posts
    #    cal1.each do |x|
    #    subcal=x.points.count
    #    fincal=fincal+subcal
    #    end
    #    dbdb=User.find(current_user.id)
    #    dbdb.level=fincal
    #    dbdb.save                
    end
    def nickup
        exist=User.where(:nickname => params[:nickname]).take
        if exist.nil?
            dbdb=User.find(current_user.id)
            dbdb.nickname=params[:nickname]
            dbdb.save
            redirect_to "/main/mypage/"
        else
            redirect_to "/main/mypage/error"
        end
    end
        
    def email_send
      receiver = params[:receiver]
      title = params[:title]
      contents = params[:contents]
      giver = params[:giver]
      Query.go_mail(receiver, title, contents, giver).deliver_now
      flash[:notice] = "전송이 완료되었습니다"
      redirect_to '/' 
    end
    
    def email_send_2
      receiver = params[:receiver]
      title = params[:title]
      contents = params[:contents]
      giver = params[:giver]
      file=params[:attachment] # attachment는 View에서 지정한 이름입니다.
      Query.go_somi(receiver, title, contents, giver, file).deliver_now
      flash[:notice] = "전송이 완료되었습니다"
      redirect_to '/' 
    end
    def likeview
        @likecontent=0
        current_user.likelogins.each do |x|
            pa=x.likecontents.count
            if pa>3
                pa=3
            end
            @likecontent=@likecontent+pa
        end   
        @likehws=0
        current_user.hws.each do |x|
            pa=x.hwslikes.count
            @likehws=@likehws+pa
        end
    end
    def likelogin
        t=Time.now
        tt="#{t.year}#{t.month}#{t.day}"
        exist=current_user.likelogins.where(:date => tt)
        if exist==[]
            db=Likelogin.new
            db.user_id=current_user.id
            db.date=tt
            db.detaildate=t
            db.save
        end      
        redirect_to '/main/likeview'
    end
    def likecontent
        t=Time.now
        tt="#{t.year}#{t.month}#{t.day}"        
        today=current_user.likelogins.where(:date => tt).take
        db=Likecontent.new
        db.likelogin_id=today.id
        db.content="hws_id"
        db.save
        redirect_to '/main/likeview'
    end    
    def createimg
        params[:sueimg].each do |x|
            db=Sueimg.new
            db.sueimg=x
            db.save
        end
        redirect_to '/main/filesize'
    end
    def imgdelete
        db=Sueimg.find(params[:id])
        db.destroy
        redirect_to '/main/filesize'
    end    
    def sue_check
        if params[:search]
            @s = Sueform.where(:you_id => params[:search])
            @r = Receive.where(:you_nickname => params[:search])
        end
    end
    def sendmessage
        require 'unirest'
        response = Unirest.post "http://api.openapi.io/ppurio/1/message/sms/greativejoo",
            headers:{:"x-waple-authorization" => "MzY5OS0xNDUyMjMxMjYxNTgyLTBiMGIyNTVhLTVlMmQtNGI0Ni04YjI1LTVhNWUyZGJiNDYzOQ=="},
            parameters:{ 
            :dest_phone => "01074172341" , 
            :dest_name => "주한결" , 
            :send_phone => "01074172341" , 
            :send_name => "고소미닷컴" , 
            :subject => "테스트" , 
            :msg_body => "테스트" , 
            :apiVersion => "1" , 
            :id => "greativejoo" 
            }
        redirect_to '/main/smstest'
    end
    def registernumber
        require 'unirest'
        response = Unirest.post "http://api.openapi.io/ppurio/1/sendnumber/save/greativejoo",
            headers:{:"x-waple-authorization" => "MzY5OS0xNDUyMjMxMjYxNTgyLTBiMGIyNTVhLTVlMmQtNGI0Ni04YjI1LTVhNWUyZGJiNDYzOQ=="},
            parameters:{
                :sendnumber =>"01074172341",
                :comment =>"관리자"
            }
        redirect_to '/main/smstest'
    end
    
    
end
