class Middleware.System.Base

  @bindMany: (selector) ->
    collection = []
    instance = @

    $(selector).each ->
      collection.push(new instance($(@)))

    collection

  @bindOne: (selector) ->
    new @($(selector))

  reBind: =>
    @.constructor(@.container)

  constructor: (@container) ->
    _.extend(@, Backbone.Events)