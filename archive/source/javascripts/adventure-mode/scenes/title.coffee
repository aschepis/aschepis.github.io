@Scenes ?= {}
class @Scenes.TitleScene
  preload: ->

  create: ->
    @game.stage.backgroundColor = '#000055'

    @title = @add.sprite(100, 20, "title")
    @add.sprite(300, 400, "new-game")
    @add.sprite(300, 480, "continue")

    @cursor = @add.sprite(260, 395, "cursor")

    @cursor.animations.add('pulse', [0,1,2,3,3,2,1], 8, true)
    @cursor.animations.play('pulse')

    @kb = @game.input.keyboard
    @kb.addKeyCapture [Phaser.Keyboard.UP, Phaser.Keyboard.DOWN, Phaser.Keyboard.ENTER]
    @kb.onDownCallback = @onKeyDown

  toggleCursor: ->
    @cursor.y = if @cursor.y == 395 then 475 else 395

  onMenuItemSelected: ->
    if @cursor.y == 395 then @game.state.start('NewGame') else alert('not implemented yet.')

  onKeyDown: (e) =>
    switch e.keyCode
      when Phaser.Keyboard.UP, Phaser.Keyboard.DOWN then @toggleCursor()
      when Phaser.Keyboard.ENTER then @onMenuItemSelected()

  update: ->
