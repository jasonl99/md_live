div#input.flex-item
  textarea data-item="#{dom_id}-textarea" data-events="input" ==@text
  div#wordcount data-item="#{dom_id}-wordcount"
    ' Wordcount goes here
div.markdown-body.markdown.flex-item data-item="#{dom_id}-markdown"
  = markdown

