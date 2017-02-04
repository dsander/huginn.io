$(document).on 'turbolinks:load', ->
  copySelector = '[data-behaviour=copy-to-clipboard]'
  clipboard = new Clipboard(copySelector)
  clipboard.on 'success', (e) ->
    $(e.trigger).tooltip(placement: 'bottom', title: 'Copied')
    $(e.trigger).tooltip('show')
  $(copySelector).on 'mouseleave', (e) ->
    $(e.currentTarget).tooltip('destroy')
