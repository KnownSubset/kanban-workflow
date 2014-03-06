`import BasicController from 'appkit/controllers/basic'`
`import BoardController from 'appkit/controllers/board'`
`import Column from 'appkit/models/column'`
`import Card from 'appkit/models/card'`
`import Board from 'appkit/models/board'`

controller = null
dispatcher = null
store = null
App = null

module("BoardController", {
  setup: ->
    App = startApp();
    store = App.__container__.lookup('store:main')
    controller = BoardController.create({container: App.__container__, store: store})
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
  ok(controller instanceof BoardController)
)

asyncTest("Should be able to add a column and have it save the new column out", 4, () ->
  Em.run -> store.find('board', 1)
  .then (board) ->
      controller.set('model', board)
      controller.send('addColumn')

  wait()

  andThen ->
    Em.run -> store.findAll('column').then (columns) ->
      column = columns.findBy('name', 'column')
      ok(column, 'new column was not found')
      Ember.RSVP.Promise.resolve(column.get('board')).then (board)->
        ok(board)
        ok(board.get('id'))
        equal(board.get('id'), 1) if board?
        start()
)
###
asyncTest("Should be able to add a column and have it appear on the board", 2, () ->
  Em.run -> store.createRecord('board', { name: 'Board #1', description: 'Lorem Ipsum', createdAt: Date() }).save()
  .then (board) ->
    controller.set('model', board)
    controller.send('addColumn')

  wait()

  andThen ->
    Em.run ->
      controller.get('model.columns').then (children) ->
        equal(children.get('length'),1)
        ok(children.findBy('name', 'column'), 'new column was not found')
        start()
)

asyncTest("Removing a board marks the model for deletion", 4, () ->
  Em.run -> store.createRecord('board', { name: 'Board #1', description: 'Lorem Ipsum', createdAt: Date() }).save()
    .then (board) ->
      ok(not board.get('isDirty'))
      ok(not board.get('isDeleted'))
      controller.set('model', board)
      controller.send('remove')

  wait()

  andThen ->
    Em.run -> store.find('board','fixture-0').then (board) ->
      ok(board.get('isDirty'))
      ok(board.get('isDeleted'), 'the board should be marked for deletion, but we can rollback until we call board.save()')
      start()
)
###
