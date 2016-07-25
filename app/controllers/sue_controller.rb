class SueController < ApplicationController
    before_action :authenticate_user!, only: [:new, :show, :edit, :cate1, :cate2, :create1]
    before_filter :require_permission, only: [:edit_confirm, :delete, :deletes]
    
    def sue_sns
        render layout: false
    end
    def sue_sns_saved
        render layout: false
    end
    def sue_internet
        render layout: false
    end
    def sue_game
        render layout: false
    end
    
    def sue_loan
        render layout: false
    end
    
    def sue_force
        render layout: false
    end
    
    def sue_forgery
        render layout: false
    end
    
    def agreement
    
    end
    
    def write_agreement
    
    end
    
    def create1
        
        dbdb=Sueform.find(params[:id])
        dbdb.police_name = params[:police_name]
        if params[:sue_sort]
            if params[:sue_sort] == "고소"
            dbdb.sue_sort = true
            else
            dbdb.sue_sort = false
            end
        end
        dbdb.you_url = params[:you_url]
        dbdb.you_id = params[:you_id]
        dbdb.birth_year = params[:birth_year]
        dbdb.birth_month = params[:birth_month]
        dbdb.birth_day = params[:birth_day]
        dbdb.my_name = params[:my_name].to_s + params[:sue_sort].to_s
        dbdb.my_game_name = params[:my_game_name]
        dbdb.my_phone = params[:my_phone]
        dbdb.sig_src = params[:sig_src]
        dbdb.post_code = params[:post_code]
        dbdb.address1 = params[:address1]
        dbdb.address2 = params[:address2] 
        dbdb.sue_reason = params[:sue_reason]
        dbdb.sue_content = params[:sue_content]
        dbdb.evidence = params[:evidence]
        if params[:evidence]
            if params[:evidence] == "yes"
            dbdb.evidence = true
            else
            dbdb.evidence = false
            end
        end
        if params[:account_number]
            dbdb.account_number = params[:account_number]
        end
        if params[:you_phone]
        dbdb.you_phone = params[:you_phone]
        end
        if params[:you_address]
        dbdb.you_address = params[:you_address]
        dbdb.you_address1 = params[:you_address1]
        dbdb.you_address2 = params[:you_address2]
        end
        if params[:record]
            if params[:record] == "yes"
            dbdb.record = true
            else
            dbdb.record = false
            end
        end
        dbdb.save
        
        unless params[:sueimg].nil?
            params[:sueimg].each do |a|
                dbdb=Sueimg.new            
                dbdb.sueform_id=params[:id]
                dbdb.sueimg=a
                dbdb.save           
            end
        end
                       
        redirect_to "/sue/show/#{params[:id]}"
    end 
    
    def edit_test
        @db = Sueform.all
        render layout: false
    end
    
    def edit_confirm
        
        dbdb=Sueform.find(params[:id])
        dbdb.police_name = params[:police_name]
        dbdb.you_url = params[:you_url]
        dbdb.you_id = params[:you_id]
        dbdb.target_date = params[:target_date]
        dbdb.my_regist = "#{params[:my_regist1]} #{params[:my_regist2]}"
        dbdb.my_name = params[:my_name]
        dbdb.my_game_name = params[:my_game_name]
        dbdb.my_phone = params[:my_phone]
        
        dbdb.post_code = params[:post_code]
        dbdb.address1 = params[:address1]
        dbdb.address2 = params[:address2] 
        
        dbdb.sue_reason = params[:sue_reason]
        dbdb.sue_content = params[:sue_content]  
        
        dbdb.save
        unless params[:sueimg].nil?
            params[:sueimg].each do |a|
                dbdb=Sueimg.new            
                dbdb.sueform_id=params[:id]
                dbdb.sueimg=a
                dbdb.save           
            end
        end
        redirect_to "/sue/show/#{params[:id]}"
    end
    
    def cate1
        if params[:choice]=='insult'
            db=Sueform.new
            db.user_id=current_user.id
            db.law_kind="모욕"
            db.save
            Sueform.all.each do |x|
            @idid=x.id
            end
            redirect_to "/sue/category_cm/#{@idid}"
        elsif params[:choice]=='forgery'
            db=Sueform.new
            db.user_id=current_user.id
            db.law_kind="인터넷사기"
            db.save
            Sueform.all.each do |x|
            @idid=x.id
            end
            redirect_to "/sue/sue_forgery/#{@idid}"
        elsif params[:choice]=='force'
            db=Sueform.new
            db.user_id=current_user.id
            db.law_kind="협박"
            db.save
            Sueform.all.each do |x|
            @idid=x.id
            end
            redirect_to "/sue/sue_force/#{@idid}"
        end
    end
    
    def cate2
        if params[:choice]=='community'
            dbdb=Sueform.find(params[:id])
            dbdb.location="커뮤니티"
            dbdb.save
            Sueform.all.each do |x|
            @idid=x.id
            end
            redirect_to "/sue/sue_internet/#{@idid}"
        elsif params[:choice]=='sns'
            dbdb=Sueform.find(params[:id])
            dbdb.location="SNS"
            dbdb.save
            Sueform.all.each do |x|
            @idid=x.id
            end
            redirect_to "/sue/sue_sns/#{@idid}"
        elsif params[:choice]=='game'
            dbdb=Sueform.find(params[:id])
            dbdb.location="게임"
            dbdb.save
            Sueform.all.each do |x|
            @idid=x.id
            end
            redirect_to "/sue/sue_game/#{@idid}"
        end
    end
    def edit1_test
        @db = Sueform.all
    end
    def deletes
        dbdb=Sueform.find(params[:id])
        dbdb.destroy
        redirect_to "/main/mypage"
    end            
    def delete
        dbdb=Sueimg.find(params[:id])
        dbdb.destroy
        redirect_to "/sue/edit_test/#{dbdb.sueform_id}"
    end       
    def show
        
        if dbdb=Sueform.where(:id => params[:id]).nil?
            redirect_to '/'
        else
            if current_user == Sueform.find(params[:id]).user || current_user.check == 1 
                dbdb=Sueform.where(:id => params[:id]).take
            else
                redirect_to '/'
            end
        end        
    end    
        
    
    def edit
        dbdb=Sueform.where(:id => params[:id]).take
        if dbdb.nil?
            redirect_to '/'
        else
            unless dbdb.user_id == current_user.id
                redirect_to '/'
            end
            render layout: false                                    
        end
    end    
    def complete 
        @p = Sueform.find(params[:id])
    end
    
    
    private
    def require_permission
    
      if current_user != Sueform.find(params[:id]).user   
        flash[:notice] = "권한이 없습니다."
        redirect_to root_path
      end
    end
end
