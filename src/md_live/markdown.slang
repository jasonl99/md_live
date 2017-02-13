html
  meta charset="UTF-8"
  link rel="stylesheet" type="text/css" href="/css/style.css"
  link rel="stylesheet" type="text/css" href="/css/markdown.css"
  script type="text/javascript" src="/js/app.js"
  script
    == javascript
body
  div#markdown.flex-container data-item=dom_id data-subscribe=""
    div#input.flex-item
      textarea data-item="#{dom_id}-textarea" data-events="input" ==@text
      div#wordcount data-item="#{dom_id}-wordcount"
        ' Wordcount goes here
    div.markdown-body.markdown.flex-item data-item="#{dom_id}-markdown"
      == markdown

