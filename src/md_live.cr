require "lattice-core"
require "./md_live/*"

module MdLive

  # serve_static({"gzip" => false, "dir_listing" => false})

  Session.config do |config|
    Session.config.secret = "foo bar"
  end


  get "/:name" do |context|
    editor = context.params.url["name"]
    unless context.session.int?("object_count")
      context.session.int("object_count",0)
    end
    javascript = MarkdownEditor.javascript(session_id: context.session.id, target: nil)
    markdown = MarkdownEditor.find_or_create(context.session.id)
    render "./src/md_live/page.slang"
  end

  get "/" do |context|
    unless context.session.int?("object_count")
      context.session.int("object_count",0)
    end
    javascript = MarkdownEditor.javascript(session_id: context.session.id, target: nil)
    markdown = MarkdownEditor.find_or_create(context.session.id)
    render "./src/md_live/page.slang"
  end

  Lattice::Core::Application.run
end
