class Middleware.System.Base

  @bindMany: (selector) ->
    collection = []
    instance = @

    if $(selector).length > 0
      $(selector).each ->
        collection.push(new instance($(@)))

    collection

  @bindOne: (selector) ->
    if $(selector).length > 0
      new @($(selector))

  reBind: =>
    @.constructor(@.container)

  constructor: (@container) ->
    _.extend(@, Backbone.Events)