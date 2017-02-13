require "lattice-core"
require "./md_live/*"

module MdLive

  Session.config do |config|
    Session.config.secret = "foo bar"
  end


  get "/:name" do |context|
    editor = context.params.url["name"]
    unless context.session.int?("object_count")
      context.session.int("object_count",0)
    end
    markdown = MarkdownEditor.find_or_create(editor)
    markdown.content session_id: context.session.id
  end

  get "/" do |context|
    unless context.session.int?("object_count")
      context.session.int("object_count",0)
    end
    markdown = MarkdownEditor.find_or_create(context.session.id)
    markdown.content session_id: context.session.id
  end

  Kemal.run
end
