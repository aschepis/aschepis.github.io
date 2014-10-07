#= require vendor/jquery
#= require vendor/underscore
#= require vendor/mousetrap
#= require vendor/headroom
#= require ../../bower_components/jquery-touchswipe/jquery.touchSwipe.js

class Cube
  constructor: (@$) ->
    Mousetrap.bind 'right', @nextPage
    Mousetrap.bind 'left', @prevPage

    @$('.page-nav a.prev, .page-nav a.next').on 'click', @handleNavClick
    @$('.page').on 'swipeleft', @nextPage
    @$('.page').on 'swiperight', @prevPage

    @$('.page').swipe(allowPageScroll:"vertical", swipeLeft:@nextPage, swipeRight:@prevPage)

    @$('a.toggle-comments').on 'click', @toggleComments
    @focus()

  swipe: (e, dir, dist, duration, fingerCount) =>
    alert("#{dir} #{dist}")

  handleNavClick: (e) =>
    e.preventDefault()
    $el = @$(e.currentTarget)
    if $el.hasClass('next')
      @nextPage()
    else if $el.hasClass('prev')
      @prevPage()
    else if $el.hasClass('menu')
      @toggleMenu()

  focus: ->
    @currentPage().find('.page .post-content').focus()

  currentPage: ->
    @$('.page-container:not(.left):not(.right)')

  prevPageEl: ->
    left = @$('.page-container.left')
    return null if left.length == 0
    @$(left[left.length - 1])

  nextPageEl: ->
    right = @$('.page-container.right')
    return null if right.length == 0
    @$(right[0])

  resetScroll: ->
    @$('.page').scrollTop(0);

  nextPage: =>
    $currentPage = @currentPage()
    $right = @nextPageEl()
    if $right?
      @resetScroll()
      @unflip()
      $right.removeClass('right')
      $currentPage.addClass('left')
      @pushState($right.attr('data-url'))
      @focus()

  prevPage: =>
    $currentPage = @currentPage()
    $left = @prevPageEl()
    if $left?
      @resetScroll()
      @unflip()
      $left.removeClass('left')
      $currentPage.addClass('right')
      @pushState($left.attr('data-url'))
      @focus()

  pushState: (url) ->
    window.history.pushState(null, null, url);

  toggleComments: (e) =>
    e.preventDefault()
    @$(e.target).closest('.page-container').children().toggleClass('flipped')
    @focus()

  unflip: ->
    $page = @currentPage()
    if $page.find('.page').hasClass('flipped')
      $page.children().toggleClass('flipped')

$ (jq) ->
  cube = new Cube(jq)
