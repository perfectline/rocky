class Middleware.Component.Modal extends Middleware.System.Base
  @create: (selector) ->
    $("body").append("<div class='modal' data-block='#{selector}'></div>")
    Middleware.Component.Modal.bindOne("*[data-block='#{selector}']")

  constructor: (@container) ->
    super(@container)

  fill: (content) =>
    @container.append(content)