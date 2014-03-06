#`import { test, moduleForModel } from 'appkit/tests/helpers/module_for'`
`import BasicView from 'appkit/views/basic'`
`import CardView from 'appkit/views/card'`

controller = null
view = null
dispatcher = null
App = null

module("{{view 'card'}}", {
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
      template: Ember.Handlebars.compile('{{view "card"}}')
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

  cardView = CardView.create({})

  ok(cardView)
  ok(cardView instanceof BasicView)
  ok(cardView instanceof CardView)
)

test("Creating a card should insert a div", () ->

  ok(view)
  ok(exists('.card'))
  ok(exists('div.card'), "A single div was inserted")
);

test("template displays nothing if model is empty", ->
  equal(view.$().text().trim(), '')
);

test("the name should be within the card", () ->
  model = Em.Object.create({name: "My name"})
  Ember.run -> controller.set('model', model)
  wait()

  ok(exists("div.card:Contains('#{model.name}')"), "the name should be within the card");
);

test("the remove event will send removeCard action", ->
  click('.card div.remove')

  andThen ->

    equal(controller.get('sendArray.firstObject'), 'remove', "The controller should have been sent the function remove")
)