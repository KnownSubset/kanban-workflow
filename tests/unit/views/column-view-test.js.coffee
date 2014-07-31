`import ColumnView from 'appkit/views/column'`

controller = null
view = null
dispatcher = null
App = null

module("{{view 'column'}}", {
  setup: ->
    App = startApp()
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
      template: Ember.Handlebars.compile('{{view "column"}}')
    })
    Ember.run(() ->  view.appendTo('#ember-testing'))

  teardown: ->
    Ember.run ->
      Ember.run(App, 'destroy')
      view.destroy()
      controller.destroy()
      dispatcher.destroy()
})

test("should be a extension of Ember.View", () ->

  columnView = ColumnView.create({})

  ok(columnView)
  ok(columnView instanceof Ember.View)
  ok(columnView instanceof ColumnView)
)

test("Creating a column should insert a div", () ->

  ok(view)
  ok(exists('.column'))
  ok(exists('div.column'), "A single div was inserted")
)

test("template displays basically nothing if model is empty", ->
  equal(view.$().text().trim(), 'Click to edit')
)

test("the name should be within the column", () ->
  model = Em.Object.create({name: "My name"})
  Ember.run -> controller.set('model', model)
  wait()

  ok(exists("div.column:Contains('#{model.name}')"), "the name should be within the column")
)

test("There should be a div for each card in the column", () ->
  model = Em.Object.create({name: "My name",  cards: [Ember.Object.create({}),Ember.Object.create({}),Ember.Object.create({})]})
  Ember.run -> controller.set('model', model)
  wait()

  cards = find('.card')
  equal(cards.length, 3)
)