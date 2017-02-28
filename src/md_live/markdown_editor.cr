require "markdown"
module MdLive
  class MarkdownEditor < Lattice::Connected::WebObject
    @text = ""

    def after_initialize
      add_element_class "flex-container"
      @element_options["id"] = "markdown"
    end

    def content
      render "./src/md_live/markdown.slang"
    end
    
    def markdown
      Markdown.to_html(@text)
    end

    def on_event( event )
      if event.component == "textarea" && event.action == "input"
        @text = event.params["value"].as(String)
        typist_socket = event.user.socket.as(HTTP::WebSocket)
        value({"id"=>dom_id("textarea"), "value"=>@text}, @subscribers - [typist_socket])
        update({"id"=>dom_id("wordcount"),"value"=>"Characters: #{@text.size} Wordcount: #{@text.split(" ").size}"})
        update({"id"=>dom_id("markdown"),"value"=>markdown})
      end
    end

  end
end
