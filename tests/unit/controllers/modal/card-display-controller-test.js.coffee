`import { test, moduleFor } from 'ember-qunit'`

[controller, store, App, card, column, testHelper] = []

moduleFor("controller:modal/card_display", "Modal - Card Display Controller", {
  needs: ['controller:modal']
  setup: ->
    App = startApp()
    testHelper = Ember.Object.createWithMixins(FactoryGuyTestMixin).setup(App)
    store = testHelper.getStore()
    controller = @subject({store: store})
    board = store.makeFixture('board')
    column = store.makeFixture('column', {board: board})
    card = store.makeFixture('card', {column: column})
    Em.run -> Em.RSVP.all([store.find('card', card.id), store.find('column', column.id)]).then (items) ->
      [card, column] = items
      controller.set('model', card)
    wait()
  teardown: ->
    Em.run(App, 'destroy')
    Em.run(testHelper, 'teardown')
})

test("Removing a card deletes it from the store", () ->
  Em.run -> controller.send('remove')

  andThen ->
    ok(card.get('isDirty'), 'the card should be marked for deletion, but we can still access it until we call card.save()')
    ok(card.get('isDeleted'), 'the card should be marked for deletion, but we can still access it until we call card.save()')
)

test("Archiving a card adds an activity item to the store", () ->
  Em.run ->
    controller.send('archive')
    wait()

  andThen ->
    ok(card.get('archived'), 'the card should be archived')
    card.get('activityStream').then (activityItems) ->
      ok(activityItems.isAny('activity', 'Card was archived!'), 'activity was not found')
)

test("Removing a card removes it from the column it belongs to", () ->
  Em.run -> controller.send('remove')

  andThen ->
    column.get('cards').then (cards) ->
      equal(cards.get('length'), 0, 'the only card should have been removed')
      ok(card.get('isDeleted'), 'the only card should have been removed')
)

test("Updating a card adds an activityItem", () ->
  Em.run ->
    card.set('description', "asdfasdf")

    controller.send('save')
    wait()

  andThen ->
    card.get('activityStream').then (stream) ->
      equal(stream.get('length'), 1, 'A new activity should have been added')
      ok(stream.isAny('activity', "description"), 'The card activity should be "Card description updated"')
)

test("Cancelling out will revert the card", () ->
  Em.run ->
    card.set('name', "asdfasdf")
    card.set('description', "asdfasdf")

    controller.send('cancel')
    wait()

  andThen ->
    ok(not card.get('isDirty'), 'card should be reverted')
    notEqual(card.get('description'), "asdfasdf", 'card should be reverted')
)
