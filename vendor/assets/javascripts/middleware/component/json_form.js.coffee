class Middleware.Component.JsonForm extends Middleware.System.Base
  constructor: (@container) ->
    super(@container)
    @initForm()

  initForm: =>
    if @container.propName("tagName") == "FORM"
      @form = @container
    else
      @form = @container.find("form")

    @form.on "ajax:success",      @createResponse
    @form.on "request:completed", @completeForm
    @form.on "request:failed",    @updateForm
    @form.on "request:cancel",    @cancelForm

    @submitButton = @form.find("*[data-action='submit']")
    @submitButton.on "click", =>
      @form.trigger("submit")

    @cancelButoon = @form.find("*[data-action='cancel']")
    @cancelButton.on "click", =>
      @form.trigger("request:cancel")

    @createResponse: (event, json) =>
      if json["completed"] == true
        @form.trigger("request:completed", json)
      else
        @form.trigger("request:failed", json)

    @completeForm: (event, json) =>

    @updateForm: (event, json) =>

    @cancelForm:  =>
      @container.remove()