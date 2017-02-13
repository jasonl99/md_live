require "markdown"
module MdLive
  class MarkdownEditor < Lattice::Connected::WebObject
    @text = ""

    def content(session_id : String )
      javascript = self.class.javascript(session_id, self)
      render "./src/md_live/markdown.slang"
    end
    
    def markdown
      Markdown.to_html(@text)
    end

    def on_event( event, speaker )
      if speaker == self && event.event_type = "subscriber"
        if event.dom_item == "#{dom_id}-textarea" && event.message_value("action") == "input"
          @text = event.message_value("params,value").as(String)
          value({"id"=>"#{dom_id}-textarea", "value"=>@text}, @subscribers - [event.socket.as(HTTP::WebSocket)])
          update({"id"=>"#{dom_id}-wordcount","value"=>"Characters: #{@text.size} Wordcount: #{@text.split(" ").size}"})
          update({"id"=>"#{dom_id}-markdown","value"=>markdown})
        end
      end
    end

  end
end
