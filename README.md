# Rocky

[![Build Status](https://travis-ci.org/Semjonow/rocky.png?branch=master)](https://travis-ci.org/Semjonow/rocky)

Current status: Middleware in development

### Latest News:
  + 26.03 JsonForm Component added to core, reBind() added to Base class.

Rocky is CoffeeScript Middleware that binds class objects with HTML page elements.
Class objects interact with page elements through Backbone events.
Rocky also implements the logic of the following components:
  Modal (Dynamic building and binding)
  Puppet page (Blank page, which closed after the action and sends instructions to the parent window)


## Installation

Add this line to your application's Gemfile:

    gem 'rocky'

And then execute:

    $ bundle
    $ rails g rocky:install

Last command will add the following lines in file (app/assets/javascripts/application.js):

    //= require underscore
    //= require backbone
    //= require middleware
    //= require application/#{your_application_name}

## Login Form example

Login Controller (SessionsController):

    def new
      @user_session = UserSession.new
    end

    def create
      @user_session = log_in(params[:user_session])

      if logged_in?
        render :json => { :completed => true, :url => root_path }
      else
        flash.now[:alert] = "Incorrect email or password"
        render :json => { :completed => false, :template => render_to_string("sessions/new") }
      end
    end

Login Template (sessions/new.haml):

    .login.form{ :data => { :block => "login_form" } }

      - flash.each do |key, value|
        %div{ :class => "alert alert-#{key == :notice ? 'success' : 'error'}" }= value

      = form_for(@user_session, :url => login_path, :remote => true, :method => :post) do |form|

        .field
          = form.label :email
          = form.text_field :email, :autofocus => true

        .field
          = form.label :password
          = form.password_field :password

        .actions
          link_to "Facebook login", "javascript:void(0)", :data => { :url => "facebook_oauth2_path",
                                                          :action => "open_connection",
                                                          :name   => "Log into My Application",
                                                          :width  => 600,
                                                          :height => 400 }

          = form.check_box :remember_me
          = form.label :remember_me, "Keep me logged in"
          = link_to "Log In", "javascript:void(0)", :data => { :action => "submit" }

Login CoffeeScript View Class (app/assets/javascripts/application/view/login.js.coffee):

         class MyApplicationName.Views.Login extends Middleware.System.Base

           constructor: (@container) ->
             super(@container)
             @initForm()

           initForm: =>
             @form = @container.find("form")

             MyApplicationName.Views.Login.initOpenConnection(@form.find("a[data-action=open_connection]"))

             @form.on "ajax:success",      @createResponse
             @form.on "request:completed", @completeForm
             @form.on "request:failed",    @updateForm

             @submitButton = @form.find("a[data-action=submit]")
             @submitButton.on "click", =>
               @form.trigger("submit.rails")

           createResponse: (event, json) =>
             if json["completed"] == true
               @form.trigger("request:completed", json)
             else
               @form.trigger("request:failed", json)

           completeForm: (event, json) =>
             window.location.replace(json["url"])

           updateForm: (event, json) =>
             @container.replaceWith(json["template"])
             MyApplicationName.Views.Login.bindMany("*[data-block=login_form]")

           @initOpenConnection: (button) ->
             button.on "click", (e) ->
               left = (screen.width/2)-(button.data("width")/2)
               top  = (screen.height/2)-(button.data("height")/2)
               window.open(button.data("url"),
                           button.data("name"),
                           "menubar=no,toolbar=no,status=no,width=#{button.data('width')},height=#{button.data('height')},toolbar=no,left=#{left},top=#{top}"
               ).focus()

               e.stopPropagation()
               return false

         jQuery ->
           MyApplicationName.Views.Login.bindMany("*[data-block=login_form]")

### Modal Example:

HTML Header:

        %header{ :data => { :block => "header" } }
          .buttons
            - if logged_in?
              = link_to "Edit account", edit_user_path(current_user), :data => { :remote => true, :action => "edit_user" }

Header CoffeeScript View Class (app/assets/javascripts/application/views/header.js.coffee):

        class MyApplicationName.Views.Header extends Middleware.System.Base

          constructor: (@container) ->
            super(@container)
            @initElements()

          initElements: =>
            @editUserButton = @container.find("a[data-action='edit_user']")
            @editUserButton.on "ajax:success", @createEditUserContainer

          createEditUserContainer: (event, json) =>
            @editUserContainer = Middleware.Component.Modal.create("edit_user")
            @editUserContainer.fill("hello")

        jQuery ->
          MyApplicationname.Views.Header.bindMany("*[data-block='header']")


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
