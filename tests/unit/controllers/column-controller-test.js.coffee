`import ColumnController from 'appkit/controllers/column'`
`import factories from 'appkit/tests/factories/domain'`
`import { test, moduleFor } from 'ember-qunit'`

[controller, store, App, board, column, testHelper, model, cards] = []

moduleFor('controller:column', '{{controller:column}}', {

  setup: ->
    App = startApp()
    testHelper = Ember.Object.createWithMixins(FactoryGuyTestMixin).setup(App)
    store = testHelper.getStore()
    controller = @subject({store: store})
    board = store.makeFixture('board')
    column = store.makeFixture('column', {board: board})
    card = store.makeFixture('card', {column: column})
    Em.run ->
      store.find('column', column.id).then (column) ->
        model = column
        controller.set('model', model)
    wait()

  teardown: ->
    Ember.run(App, 'destroy')
    Ember.run(testHelper, 'teardown')

})

test("should be a extension of the Ember.Controller", () ->
  ok(controller)
  ok(controller instanceof Ember.Controller)
  ok(controller instanceof ColumnController)
)

test("Removing a column deletes it from the store", () ->
  andThen -> Em.run -> controller.send('remove')

  andThen ->
    ok(model.get('isDirty'))
    ok(model.get('isDeleted'), "the column should be marked for deletion, but we can still access it until we call column.save()")
)

test("dropping a card from one column to another moves it the current column", () ->
  column2 = store.makeFixture('column', {board: board})
  card2 = store.makeFixture('card', {column: column2})

  andThen ->
    controller.send('dropped', [card2.id])

  andThen ->
    Em.run -> model.get('cards').then (cards) ->
      ok(cards.isAny('id', card2.id))
)

test("dropping a card from one column to adds an activity item to the card", () ->
  column2 = store.makeFixture('column', {board: board})
  card2 = store.makeFixture('card', {column: column2})

  andThen ->
    controller.send('dropped', [card2.id])

  andThen ->
    store.find('card', card2.id).then (card) ->
      card.get('activityStream')
    .then (activityItems) ->
      activity = "Card moved to #{Ember.get(column, 'name')}"
      ok(activityItems.isAny('activity', activity), "activity not moved: #{activity}")
)
