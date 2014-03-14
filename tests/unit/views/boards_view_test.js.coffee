#`import { test, moduleForModel } from 'appkit/tests/helpers/module_for'`
`import Board from 'appkit/models/board'`

controller = null
view = null
dispatcher = null
App = null
boards = null

module("{{view 'boards'}}", {
  setup: ->
    boards = [
      {
        id:1,
        name: 'Board #1',
        description: 'Proin',
        createdAt: Date(),
        columns: [1,2,3]
      },{
        id:2,
        name: 'Board #1',
        description: 'Quisque',
        createdAt: Date(),
        columns: [4]
      },{
        id:3,
        name: 'Board #3',
        description: 'Curabitur',
        createdAt: Date(),
        columns: [5,6,7]
      }
    ]
    App = startApp();
    dispatcher = Ember.EventDispatcher.create()
    dispatcher.setup()
    Controller = Ember.Controller.extend({})
    controller = Controller.create({
      container: App.__container__,
      sendArray: [],
      send: (action) ->
        sendArray = @get('sendArray')
        sendArray.push(action)
    })
    view = Ember.View.create({
      templateName: 'boards'
      controller: controller,
      container: App.__container__,
    })
    Ember.run ->  controller.set('model', boards)
    Ember.run(() ->  view.appendTo('#ember-testing'))

  teardown: ->
    Ember.run ->
      Ember.run(App, 'destroy')
      view.destroy()
      controller.destroy()
      dispatcher.destroy()
})


test("Displaying the boards show up in div tags", () ->
  ok(view)
  ok(exists('.board'))
  ok(exists('div.board'), "A div was inserted")
  equal(find('div.board').length, boards.length, "A single div was inserted")
)

test("Creating a board should insert a div", () ->
  click("button:contains('Create Board')")

  andThen ->
    equal(controller.get('sendArray.firstObject'), 'addBoard', "The controller should have been sent the addBoard action")
)
