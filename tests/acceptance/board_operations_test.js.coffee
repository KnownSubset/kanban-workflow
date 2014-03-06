`import Board from 'appkit/models/board'`
`import Column from 'appkit/models/column'`
`import Card from 'appkit/models/card'`

App = null

module('Acceptances - Board', {
  setup: ->
    App = startApp()
    Board.FIXTURES = [ { id:1, name: 'Board #1', description: 'Proin.', createdAt: Date(), columns: [1] } ]
    Column.FIXTURES = [ { id:1, name: 'column #1_1', kind: 'manual', createdAt: Date(), cards: [1], board: 1 } ]
    Card.FIXTURES = [ { id:1, name: 'card #1', description: 'Lorem.', column: 1 } ]
  teardown: ->
    Ember.run(App, 'destroy');
})

test('Board renders', 1, ->
  board = Board.FIXTURES[0]

  visit("/board/#{board.id}")

  andThen ->
    boardElement = find("div.board:contains('#{board.name}')")
    ok(boardElement, "board for #{board.name} should exist")
)

test('Board renders out all current columns', 1, ->
  board = Board.FIXTURES[0]
  column = Column.FIXTURES[0]

  visit("/board/#{board.id}")

  andThen ->
    columnElement = find("div.board div.column:contains('#{column.name}')")
    ok(columnElement, "column for #{column.name} should exist")
)

test('User can add a column to the board', 1, ->
  board = Board.FIXTURES[0]
  visit("/board/#{board.id}")
  click("div.board button#add_column")
  andThen ->
    columnElements = find('div.board div.column')

    equal(columnElements.length, 2, "there should be another column")

)

