#= require phaser/phaser.js
#= require_tree ./adventure-mode

Scenes = @Scenes
class @AdventureMode
  constructor: ->
    @game = new Phaser.Game(800, 600, Phaser.AUTO, document.getElementById('container'));
    # TODO: do this via a JSON file generated from middleman.
    @game.state.add('Boot', Scenes.BootScene)
    @game.state.add('Loading', Scenes.LoadingScene)
    @game.state.add('Title', Scenes.TitleScene)
    @game.state.add('NewGame', Scenes.NewGameScene)

    @game.state.start('Boot')