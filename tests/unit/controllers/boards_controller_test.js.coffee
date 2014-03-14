`import BoardsController from 'appkit/controllers/boards'`
`import Column from 'appkit/models/column'`
`import Card from 'appkit/models/card'`
`import Board from 'appkit/models/board'`

controller = null
dispatcher = null
store = null
App = null

module("Boards Controller", {
  setup: ->
    App = startApp();
    store = App.__container__.lookup('store:main')
    controller = BoardsController.create({container: App.__container__, store: store})

  teardown: ->
    Ember.run ->
      Ember.run(App, 'destroy')
      controller.destroy()

})

test("should be a extension of the Basic controller", () ->
  ok(controller)
  ok(controller instanceof Ember.ArrayController)
  ok(controller instanceof BoardsController)
)

asyncTest("Should be able to add a board and have it save the new column out", 3, () ->
  Board.FIXTURES = [ { id:1, name: 'Board #1', description: 'Proin.', createdAt: Date(), columns: [1] } ]
  Column.FIXTURES = [ { id:1, name: 'column #1_1', kind: 'manual', createdAt: Date(), cards: [1], board: 1 } ]
  Card.FIXTURES = [ { id:1, name: 'card #1', description: 'Lorem.', column: 1 } ]
  Em.run ->
    store.findAll('board').then (boards) ->
      controller.set('model', boards)
  Em.run -> controller.send('addBoard')

  wait()

  andThen ->
    newBoard = controller.get('model.firstObject')
    ok(not newBoard.get('isDirty'), 'The created board should be saved')
    ok(not newBoard.get('isNew'), 'The created board should be saved')
    equal(newBoard.get('name'),'new board')
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
