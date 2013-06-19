class Middleware.Component.JsonForm extends Middleware.System.Base
  constructor: (@container) ->
    super(@container)
    @initForm()

  initForm: =>
    if @container.prop("tagName") == "FORM"
      @form = @container
    else
      @form = @container.find("form")

    if @form.length == 0
      return false

    @form.on "ajax:success",      @createResponse
    @form.on "request:completed", @completeForm
    @form.on "request:failed",    @updateForm
    @form.on "request:cancel",    @cancelForm

    @submitButton = @form.find("*[data-action='submit']")
    @submitButton.on "click", =>
      @form.trigger("submit.rails")

    @form.find("input").keypress (e) =>
      if e.which == 13
        @form.trigger("submit.rails")
        e.preventDefault()

    @cancelButton = @form.find("*[data-action='cancel']")
    @cancelButton.on "click", =>
      @form.trigger("request:cancel")

  createResponse: (event, json) =>
    if json[Middleware.Env.getSuccessStatus()] == true
      @form.trigger("request:completed", json)
    else
      @form.trigger("request:failed", json)

  completeForm: (event, json) =>

  updateForm: (event, json) =>

  cancelForm:  =>
    @container.remove()
