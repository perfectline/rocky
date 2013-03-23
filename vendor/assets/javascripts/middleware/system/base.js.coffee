class Middleware.System.Base

  @bindMany: (selector) ->
    collection = []
    instance = @

    $(selector).each ->
      collection.push(new instance($(@)))

    collection

  @bindOne: (selector) ->
    new @($(selector))

  constructor: (@container) ->
    _.extend(@, Backbone.Events)