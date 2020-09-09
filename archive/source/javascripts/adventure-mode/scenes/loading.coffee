@Scenes ?= {}
class @Scenes.LoadingScene
  preload: ->
    @load.image('title', '/images/adventure-mode/title.png');
    @load.image('new-game', '/images/adventure-mode/new-game.png');
    @load.image('continue', '/images/adventure-mode/continue.png');
    @load.spritesheet('cursor', '/images/adventure-mode/cursor-sheet.png', 32, 32, 4);
    # load "loading assets"

  create: ->
    @game.state.start("Title");