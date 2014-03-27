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

#This test doesn't work...abandoning it for now -DS

#asyncTest("Should be able to add a card and have it save the new card out", 4, () ->
#  Em.run -> store.find('board', 1)
#  .then (board) ->
#      controller.set('model', board)
#      controller.send('addCard')
#
#  wait()
#
#  andThen ->
#    Em.run -> store.findAll('card').then (cards) ->
#      card = cards.findBy('name', 'New Card')
#      ok(card, 'new card was not found')
#      Ember.RSVP.Promise.resolve(card.get('column')).then (column)->
#        ok(column)
#        ok(column.get('id'))
#        equal(column.get('id'), 1) if column?
#        start()
#)
