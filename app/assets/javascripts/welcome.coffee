# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  HomeJs.init()

HomeJs =
  init: ->
    $('a.page-scroll').bind 'click', (event) ->
      $anchor = $(this)
      $('html, body').stop().animate { scrollTop: $($anchor.attr('href')).offset().top - 50 }, 1250, 'easeInOutExpo'
      event.preventDefault()

    # Highlight the top nav as scrolling occurs
    $('body').scrollspy
      target: '.navbar-fixed-top'
      offset: 100
    # Closes the Responsive Menu on Menu Item Click
    $('.navbar-collapse ul li a').click ->
      $('.navbar-toggle:visible').click()

    # Offset for Main Navigation
    $('#mainNav').affix offset: top: 50
