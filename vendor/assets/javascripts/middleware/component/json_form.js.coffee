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

    @form.on "ajax:success",     @createResponse
    @form.on "response:success", @completeForm
    @form.on "response:error",   @updateForm
    @form.on "response:cancel",  @cancelForm

    @submitButton = @form.find("*[data-action='submit']")
    @submitButton.on "click", =>
      @form.trigger("submit.rails")

    @form.find("input").keypress (e) =>
      if e.which == 13
        @form.trigger("submit.rails")
        e.preventDefault()

    @cancelButton = @form.find("*[data-action='cancel']")
    @cancelButton.on "click", =>
      @form.trigger("response:cancel")

  createResponse: (event, json) =>
    if json[Middleware.Env.getSuccessStatus()] == true
      @form.trigger("response:success", json)
    else
      @form.trigger("response:error", json)

  completeForm: (event, json) =>

  updateForm: (event, json) =>

  cancelForm:  =>
    @container.remove()
