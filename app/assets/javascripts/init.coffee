# http://brandonhilkert.com/blog/organizing-javascript-in-rails-application-with-turbolinks/

window.App ||= {}

App.init =
  tooltips: ->
    $('[data-toggle="tooltip"]').tooltip()


  # initialize things that are used on every page
  initialize: ->
    App.init.tooltips()

$(document).on "turbolinks:load", ->
  App.init.initialize()

