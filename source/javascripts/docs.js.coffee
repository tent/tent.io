panelToggleElement = ->
  el = document.createElement('button')
  el.className = 'btn btn-primary panel-toggle'
  el

clearFixElement = ->
  el = document.createElement('div')
  el.className = 'clearfix'
  el

PANEL_TOGGLE_EXPAND_TEXT = "Expand"
PANEL_TOGGLE_COLLAPSE_TEXT = "Collapse"

CSS_HIDDEN_CLASS = "hidden"

addEventListener = (el, events, callback, capture=false) ->
  return unless el
  method = 'addEventListener' if el.addEventListener
  method ?= 'attachEvent' if el.attachEvent
  return unless method

  for event in events.split(' ')
    el[method](event, callback, capture)

prependChild = (el, node) ->
  if el.firstChild
    el.insertBefore(node, el.firstChild)
  else
    el.appendChild(node)

class Panel
  constructor: (@el) ->
    @elements = {
      heading: @el.querySelector('.panel-heading')
      body: @el.querySelector('.panel-body')
      toggle: panelToggleElement()
    }

    addEventListener(@elements.toggle, 'click', @toggleBody)

    prependChild(@el, clearFixElement())
    prependChild(@el, @elements.toggle)
    prependChild(@el, @elements.heading) if @elements.heading

    @hideBody()

  toggleBody: (e) =>
    if @hidden
      @showBody()
    else
      @hideBody()

  hideBody: =>
    @hidden = true
    @elements.toggle.innerHTML = PANEL_TOGGLE_EXPAND_TEXT

    classes = @elements.body.className.split(' ')
    classes.push(CSS_HIDDEN_CLASS) if classes.indexOf(CSS_HIDDEN_CLASS) == -1
    @elements.body.className = classes.join(' ')

  showBody: =>
    @hidden = false
    @elements.toggle.innerHTML = PANEL_TOGGLE_COLLAPSE_TEXT

    classes = @elements.body.className.split(' ')
    unless (index = classes.indexOf(CSS_HIDDEN_CLASS)) == -1
      delete classes[index]
    @elements.body.className = classes.join(' ')

for el in document.querySelectorAll('.panel')
  new Panel(el)

