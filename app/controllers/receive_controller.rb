class ReceiveController < ApplicationController
  def insult
    if params[:crimi]
          dbdb = Receive.new
          dbdb.cate = "normal"
          dbdb.category = params[:category]
          dbdb.you_nickname = params[:you_nickname]
          dbdb.location = params[:location]
          if params[:game_category] == '기타'
            dbdb.reason = params[:reason]
            if params[:contents] ==''
              dbdb.content = params[:reason] +"로 제보되었습니다."
            else
              dbdb.content = params[:content]
            end
          else
            if params[:contents] == ''
            dbdb.reason = params[:game_category]
            dbdb.content = params[:game_category] +"로 제보되었습니다."
            else
            dbdb.reason = params[:game_category]
            dbdb.content = params[:contents]
            end
          end
          dbdb.save
            unless params[:attachment].nil?
            receiver = params[:receiver]
            title = '불량유저제보'
            contents = params[:bad]
            giver = params[:giver]
            file=params[:attachment] # attachment는 View에서 지정한 이름입니다.
            Query.go_somi(receiver, title, contents, giver, file).deliver_now
            flash[:notice] = "제보가 접수되었습니다."
            redirect_to '/'
            else
            flash[:notice] = "제보가 접수되었습니다."
            redirect_to '/'
            end
    elsif params[:celebrity]
          dbdb = Receive.new
          dbdb.cate = "celebrity"
          dbdb.category = params[:title]
          dbdb.you_nickname = params[:you_nickname]
          dbdb.location = "악플러 신고"
          dbdb.content = params[:title]
          dbdb.reason = "악성 댓글"
          dbdb.save
          receiver = params[:receiver]
          title = params[:title]
          contents = params[:bad]
          giver = params[:giver]
          file=params[:attachment] # attachment는 View에서 지정한 이름입니다.
          Query.go_somi(receiver, title, contents, giver, file).deliver_now
          flash[:notice] = "제보가 접수되었습니다."
          redirect_to '/'
    else
            count = Consult.new
            count.save
            receiver = params[:receiver]
            title = params[:title]
            contents = params[:contents]
            giver = params[:giver]
            file=params[:attachment] # attachment는 View에서 지정한 이름입니다.
            Query.go_somi(receiver, title, contents, giver, file).deliver_now
            flash[:notice] = "상담이 접수되었습니다."
            redirect_to '/'
    end
  end

  def celebrity


          unless Celebrity.where("ce_name LIKE ?", "%#{params[:ce_name]}%").present?
          dbdb = Celebrity.new
          dbdb.cate = params[:category]
          dbdb.ce_name = params[:ce_name]
          dbdb.site_name = params[:site_name]
          dbdb.you_nickname = params[:you_nickname]
          dbdb.count = 1
          dbdb.save
          receiver = params[:receiver]
          title = params[:ce_name]
          contents = params[:bad]
          giver = params[:giver]
          file=params[:attachment] # attachment는 View에서 지정한 이름입니다.
          Query.go_somi(receiver, title, contents, giver, file).deliver_now
          flash[:notice] = "제보가 접수되었습니다."
            @idid=Celebrity.count.to_i
            redirect_to "/receive/gosomi_complete/#{@idid}"
          else
          s = Celebrity.where("ce_name LIKE ?", "%#{params[:ce_name]}%").take
          s.count =  s.count + 1
          @idid = s.id
          dbdb = Receive.new
          dbdb.cele_id = s.id
          s.save
          dbdb.you_nickname = params[:you_nickname]
          dbdb.cate = params[:category]
          dbdb.location = params[:site_name]
          dbdb.save
          receiver = params[:receiver]
          title = params[:ce_name]
          contents = params[:bad]
          giver = params[:giver]
          file=params[:attachment] # attachment는 View에서 지정한 이름입니다.
          Query.go_somi(receiver, title, contents, giver, file).deliver_now
          flash[:notice] = "제보가 접수되었습니다."
          redirect_to "/receive/gosomi_complete/#{@idid}"
          end

  end

  def gosomi_complete

      @a = Celebrity.where(:ce_name => params[:ce_name])
  end

end
