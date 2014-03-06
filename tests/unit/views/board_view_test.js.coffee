#`import { test, moduleForModel } from 'appkit/tests/helpers/module_for'`
`import BasicView from 'appkit/views/basic'`
`import BoardView from 'appkit/views/board'`

controller = null
view = null
dispatcher = null
App = null

module("{{view 'board'}}", {
  setup: ->
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
      controller: controller,
      container: App.__container__,
      template: Ember.Handlebars.compile('{{view "board"}}')
    })
    Ember.run(() ->  view.appendTo('#ember-testing'))

  teardown: ->
    Ember.run ->
      Ember.run(App, 'destroy')
      view.destroy()
      controller.destroy()
      dispatcher.destroy()
})

test("should be a extension of Ember's BasicView", () ->

  columnView = BoardView.create({})

  ok(columnView)
  ok(columnView instanceof BasicView)
  ok(columnView instanceof BoardView)
)

test("Creating a column should insert a div", () ->

  ok(view)
  ok(exists('.board'))
  ok(exists('div.board'), "A single div was inserted")
);

test("template displays nothing if model is empty", ->
  equal(view.$().text().trim(), '')
);

test("the name should be within the column", () ->
  model = Em.Object.create({name: "My name"})
  Ember.run -> controller.set('model', model)
  wait()

  ok(exists("div.board:Contains('#{model.name}')"), "the name should be within the column");
);

test("There should be a div for each column in the board", () ->
  model = Em.Object.create({name: "My name",  columns: [Ember.Object.create({}),Ember.Object.create({}),Ember.Object.create({})]})
  Ember.run -> controller.set('model', model)
  wait()

  cards = find('.column')
  equal(cards.length, 3)
);