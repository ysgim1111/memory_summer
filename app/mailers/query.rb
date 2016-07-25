class Query < ApplicationMailer
=begin    
    def go_mail receiver, title, contents, giver
        
         mail subject: title,
             body: contents,
             to: receiver,
             from: giver
    end
=end    
    def go_somi receiver, title, contents, giver, file
        unless file.nil?
          if file.kind_of?(Array)
            file.each do |x|
              attachments[x.original_filename] = x.read
            end  
          else
              attachments[file.original_filename] = file.read
          end
        end
         mail subject: title,
             body: contents,
             to: receiver,
             from: giver
    end
end
