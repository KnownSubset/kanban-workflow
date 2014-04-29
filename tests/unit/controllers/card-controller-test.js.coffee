`import CardController from 'appkit/controllers/card'`
`import factories from 'appkit/tests/factories/domain'`
`import { test, moduleFor } from 'ember-qunit'`

[controller, store, App, board, testHelper] = []

moduleFor('controller:card', '{{controller:card}}', {
  setup: ->
    App = startApp();
    testHelper = Ember.Object.createWithMixins(FactoryGuyTestMixin).setup(App)
    store = testHelper.getStore()
    controller = @subject({store: store})

  teardown: ->
    Ember.run(App, 'destroy')
    Ember.run(testHelper, 'teardown')

})

test("should be a extension of the Basic controller", () ->
  ok(controller)
  ok(controller instanceof Ember.Controller)
  ok(controller instanceof CardController)
)

test("the description defaults to an empty string if there is no model", () ->
  equal(controller.get('description'), "")
)

test("the card should display a short description", () ->
  model = store.makeFixture('card',{description: "012345678901234567890123456789"})

  Ember.run -> controller.set('model', model)

  equal(model.description.length, 30);
  equal(controller.get('description'), model.description)
)

test("the card should truncate long descriptions", () ->
  model = store.makeFixture('card',{description: "012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"})

  Ember.run -> controller.set('model', model)

  equal(model.description.length, 90);
  equal(controller.get('description'), "#{model.description.substring(0,30)}...", "the card should display a cut-off description")
)

test("Removing a card deletes it from the store", () ->
  column = store.makeFixture('column')
  card = store.makeFixture('card', {column: column})
  Em.run ->
    store.find('card', card.id).then (card) ->
      controller.set('model', card)
  wait()

  andThen ->
    controller.send('remove')

  andThen ->
    store.find('card', card.id).then (card) ->
      ok(card.get('isDirty'), 'the card should be marked for deletion, but we can still access it until we call card.save()')
      ok(card.get('isDeleted'), 'the card should be marked for deletion, but we can still access it until we call card.save()')
)

test("Removing a card removes it from the column it belongs to", () ->
  column = store.makeFixture('column')
  card = store.makeFixture('card', {column: column})
  Em.run ->
    store.find('card', card.id).then (card) ->
      controller.set('model', card)
  wait()

  andThen ->
    controller.send('remove')

  andThen ->
    store.find('column',column.id)
    .then (column) -> column.get('cards')
    .then (cards) ->
      ok(not cards.anyBy('id', card.id), 'the only card should have been removed')
)
