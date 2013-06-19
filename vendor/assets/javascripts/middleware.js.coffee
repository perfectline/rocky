#= require_self
#= require_tree ./middleware/system
#= require_tree ./middleware/component

window.Middleware = {
  Env:    {}
  System: {}
  Component: {}
  }

window.Middleware.Env = new Middleware.System.Env