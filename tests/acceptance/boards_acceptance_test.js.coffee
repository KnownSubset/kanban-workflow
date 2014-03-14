`import Board from 'appkit/models/board'`

App = null

module('Acceptances - Boards', {
  setup: ->
    App = startApp()
    Board.FIXTURES = [ {
      id:1,
      name: 'Board #1',
      description: 'Proin',
      createdAt: Date(),
    },{
      id:2,
      name: 'Board #1',
      description: 'Quisque',
      createdAt: Date(),
    },{
      id:3,
      name: 'Board #3',
      description: 'Curabitur',
      createdAt: Date(),
    } ]
  teardown: ->
    Ember.run(App, 'destroy');
})

test('Each board is displayed', ->
  expect(Board.FIXTURES.length)

  visit("/boards")

  andThen ->
    Board.FIXTURES.forEach (board) ->
      ok(find("div.board:contains('#{board.name}')"), "board for #{board.name} should exist")
)

test('click a board, visits that board', 2, ->
  board = Board.FIXTURES[0]

  visit("/boards")
  click("div.board:contains('#{board.name}')")

  andThen ->
    ok(find("div.board:contains('#{board.name}')"), "board for #{board.name} should exist")
    equal(find("div.board").length, 1, "only a single board should be displayed")

    #As far as I can tell, there's no way to actually access currentPath (same as triggerEvent)
    #and the resources I've read indicate that testing route transitions is broken/not necessary. -DS
    #currentPath(App)

)
