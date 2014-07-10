#= require vendor/jquery
#= require vendor/jquery.detect_swipe
#= require vendor/underscore
#= require vendor/mousetrap

class Cube
  constructor: (@$) ->
    Mousetrap.bind 'right', @nextPage
    Mousetrap.bind 'left', @prevPage

    # @$('body').on 'touchstart mousedown', @startDrag
    # @$('body').on 'touchend mouseup', @endDrag
    @$('.page-nav a').on 'click', (e) =>
      e.preventDefault()
      if @$(e.currentTarget).hasClass('next') then @nextPage() else @prevPage()
    @$('a.toggle-comments').on 'click', @toggleComments

    @focus()

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

  startDrag: (e) =>
    return unless e.which == 1
    @start =
      x: e.pageX
      y: e.pageY

  endDrag: (e) =>
    return unless @start?
    t = e.pageX - @start.x
    nextEl = if t > 0 then @prevPageEl() else @nextPageEl()
    if nextEl?
      percentage = if t? then t / $('body').width() else 0
      if Math.abs(percentage) > 0.33 || Math.abs(t) > 50
        if t > 0 then @prevPage() else @nextPage()

    @start = null
    @

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
