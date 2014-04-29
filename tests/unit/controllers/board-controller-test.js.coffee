`import BoardController from 'appkit/controllers/board'`
`import factories from 'appkit/tests/factories/domain'`
`import { test, moduleFor } from 'ember-qunit'`

[controller, store, App, model, board, card, column, columns, cards, testHelper] = []

moduleFor('controller:board', '{{controller:board}}', {
  setup: ->
    App = startApp()
    testHelper = Ember.Object.createWithMixins(FactoryGuyTestMixin).setup(App)
    store = testHelper.getStore()
    controller = @subject({store: store})
    board = store.makeFixture('board')
    column = store.makeFixture('column', {board: board})
    card = store.makeFixture('card', {column: column})
    Em.run ->
      store.find('board', board.id).then (board) ->
        model = board
        controller.set('model', model)
    wait()

  teardown: ->
    Em.run(App, 'destroy')
    Em.run(testHelper, 'teardown')

})

test("should be a extension of the Ember controller", () ->
  ok(controller)
  ok(controller instanceof Ember.Controller)
  ok(controller instanceof BoardController)
)

test("Should be able to add a column and have it save the new column out", () ->
  andThen -> Em.run -> controller.send('addColumn')

  andThen ->
    Em.run -> store.findAll('column').then (columns) ->
      column = columns.findBy('name', 'column')
      ok(column, 'new column was not found')
      column.get('board')
    .then (board)->
      equal(board.get('id'), model.get('id'))
      model.get('columns')
    .then (columns) ->
      ok(columns.anyBy('name', 'column'), 'new column should be in the list of columns')
)


test("Removing a column removes it from the board it belongs to", () ->
  andThen ->
    Em.RSVP.all([store.find('board', board.id), store.find('column', column.id)]).then (promises) ->
      [board, column] = promises
      controller.set('model', board)

      controller.send('remove', column)

  andThen ->
    store.find('board',board.id)
    .then (board) -> board.get('columns')
      .then (columns) ->
          equal(columns.get('length'), 0, 'the only column should have been removed')
)


###
test("Should be able to add a card and have it save the new card out", () ->
  Em.run -> controller.send('addCard')

  andThen ->
    Em.run -> store.findAll('card').then (cards) ->
      card = cards.findBy('name', 'New Card')
      ok(card, 'new card was not found')
      column.get('cards')
    .then (cards) ->
      equal(cards.get('length'), 2)
)

test("Removing a board deletes it from the store", () ->
  Em.run ->
    store.find('board', board.id)
  .then (board2) ->
    ok(not board2.get('isDirty'))
    ok(not board2.get('isDeleted'))
    controller.set('model', board2)
    controller.send('remove')
    ok(board2.get('isDirty'), 'the card should be marked for deletion, but we can still access it until we call card.save()')
    ok(board2.get('isDeleted'), 'the card should be marked for deletion, but we can still access it until we call card.save()')
)

###