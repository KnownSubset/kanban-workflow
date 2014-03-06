`import BasicController from 'appkit/controllers/basic'`
`import CardController from 'appkit/controllers/card'`
`import Column from 'appkit/models/column'`
`import Card from 'appkit/models/card'`
`import Board from 'appkit/models/board'`

controller = null
dispatcher = null
store = null
App = null

module("CardController", {
  setup: ->
    App = startApp();
    controller = CardController.create({container: App.__container__})
    store = App.__container__.lookup('store:main')
    Board.FIXTURES = [ { id:1, name: 'Board #1', description: 'Proin.', createdAt: Date(), columns: [1] } ]
    Column.FIXTURES = [ { id:1, name: 'column #1_1', kind: 'manual', createdAt: Date(), cards: [1], board: 1 } ]
    Card.FIXTURES = [ { id:1, name: 'card #1', description: 'Lorem.', column: 1 } ]

  teardown: ->
    Ember.run ->
      Ember.run(App, 'destroy')
      controller.destroy()

})

test("should be a extension of the Basic controller", () ->
  ok(controller)
  ok(controller instanceof BasicController)
  ok(controller instanceof CardController)
)

test("the description defaults to an empty string if there is no model", () ->
  model = Em.Object.create({description: "012345678901234567890123456789"})

  Ember.run -> controller.set('model', null)
  wait()

  equal(controller.get('description'), "")
)

test("the card should display a short description", () ->
  model = Em.Object.create({description: "012345678901234567890123456789"})

  Ember.run -> controller.set('model', model)
  wait()

  equal(model.description.length, 30);
  equal(controller.get('description'), model.description)
)

test("the card should truncate long descriptions", () ->
  model = Em.Object.create({description: "012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"})

  Ember.run -> controller.set('model', model)
  wait()

  equal(model.description.length, 90);
  equal(controller.get('description'), "#{model.description.substring(0,30)}...", "the card should display a cut-off description")
)

asyncTest("Removing a card deletes it from the store", 4, () ->
  Em.run -> store.find('card', Card.FIXTURES[0].id)
    .then (card)->
      ok(not card.get('isDirty'))
      ok(not card.get('isDeleted'))
      controller.set('model', card)
      controller.send('remove')

  andThen ->
    Em.run -> store.find('card',Card.FIXTURES[0].id).then (cards) ->
      ok(cards.get('isDirty'))
      ok(cards.get('isDeleted'), 'the card should be marked for deletion, but we can still access it until we call card.save()')
      start()
)

asyncTest("Removing a card removes it from the column it belongs to", 1, () ->
  Em.run -> store.find('card', Card.FIXTURES[0].id)
    .then (card)->
      controller.set('model', card)
      controller.send('remove')

  andThen ->
    Em.run -> store.find('column',Column.FIXTURES[0].id)
      .then (column) -> Em.RSVP.Promise.resolve(column.get('cards'))
      .then (cards) ->
        equal(cards.get('length'), 0, 'the only card should have been removed')
        start()
)
