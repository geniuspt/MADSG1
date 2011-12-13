require 'redcloth'

class RedClothCustom

  # Transforms the follwing Textile markups:
  # 
  #   [media=210      | Das Huhn] -> <a href="/media_entries/210">Das Huhn</a>
  #   [screenshot=210 | Das Huhn] -> <img src="/media_entries/210/image" title="Das Huhn"/>
  #   [video=210      | Das Huhn] -> <video src="/media_entries/210/image" title="Das Huhn"/>
  #                                    <a href='/media_entries/210'>(see video)</a>
  #                                  </video>
  #
  def self.replace_custom_tags(text)

    # unfortunately having multiple matches in gsub doesn't seem to work, therefore
    # we fall back to $1 $2
    #
	text.gsub(/\[\s*usecase\s*=\s*(\d+)\s*\|\s*((?:[a-zA-Z0-9])+)*\s*\]/) { |number,txt|
           "<a href='/usecase/#{$1}'>#{h($2)}</a>"                 }
  end
  
  def format( text )
    ::RedCloth.new(replace_custom_tags(text)).to_html
  end
  
  def self.new( text )
    ::RedCloth.new(replace_custom_tags(text)).to_html
  end
end