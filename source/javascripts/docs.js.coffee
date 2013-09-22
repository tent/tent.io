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

addClass = (el, class_name) ->
  classes = el.className.split(' ')
  classes.push(class_name) if classes.indexOf(class_name) == -1
  el.className = classes.join(' ')

removeClass = (el, class_name) ->
  classes = el.className.split(' ')
  unless (index = classes.indexOf(class_name)) == -1
    classes = classes.slice(0, index).concat(classes.slice(index+1, classes.length))
  el.className = classes.join(' ')

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

    addClass(@elements.body, CSS_HIDDEN_CLASS)

  showBody: =>
    @hidden = false
    @elements.toggle.innerHTML = PANEL_TOGGLE_COLLAPSE_TEXT

    removeClass(@elements.body, CSS_HIDDEN_CLASS)

for el in document.querySelectorAll('.panel')
  new Panel(el)

