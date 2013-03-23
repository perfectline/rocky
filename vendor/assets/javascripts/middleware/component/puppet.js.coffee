class Middleware.Component.Puppet extends Middleware.System.Base
  constructor: (@container) ->
    super(@container)
    @initPage()

  initPage: =>
    window.close()

    if @container.data("trigger") == "redirect"
      window.opener.location = @container.data("url")
    end

jQuery ->
  Middleware.Component.Puppet.bindMany("*[data-block=puppet_page]")