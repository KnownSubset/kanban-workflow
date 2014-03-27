`import BasicController from 'appkit/controllers/basic'`
`import ColumnController from 'appkit/controllers/column'`
`import Column from 'appkit/models/column'`
`import Card from 'appkit/models/card'`
`import Board from 'appkit/models/board'`

controller = null
dispatcher = null
store = null
App = null

module("ColumnController", {
  setup: ->
    App = startApp();
    controller = ColumnController.create({container: App.__container__})
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
  ok(controller instanceof ColumnController)
)

asyncTest("Removing a column deletes it from the store", 4, () ->
  Em.run -> store.find('column', Column.FIXTURES[0].id)
    .then (column)->
      ok(not column.get('isDirty'))
      ok(not column.get('isDeleted'))
      controller.set('model', column)
      controller.send('remove')

  andThen ->
    Em.run -> store.find('column',Column.FIXTURES[0].id).then (column) ->
      ok(column.get('isDirty'))
      ok(column.get('isDeleted'), "the column should be marked for deletion, but we can still access it until we call column.save()")
      start()
)

asyncTest("Removing a column removes it from the board it belongs to", 1, () ->
  Em.run -> store.find('column', Column.FIXTURES[0].id)
    .then (column)->
      controller.set('model', column)
      controller.send('remove')

  andThen ->
    Em.run -> store.find('board',Board.FIXTURES[0].id)
      .then (board) -> Em.RSVP.Promise.resolve(board.get('columns'))
      .then (columns) ->
        equal(columns.get('length'), 0, 'the only column should have been removed')
        start()
)
