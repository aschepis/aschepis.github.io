@Scenes ?= {}
class @Scenes.BootScene
  preload: ->
    # load "loading assets"

  create: ->
    @game.state.start("Loading");