[App, testHelper, boards] = []

module('Acceptances - Boards', {
  setup: ->
    App = startApp()
    testHelper = Ember.Object.createWithMixins(FactoryGuyTestMixin).setup(App)
    store = testHelper.getStore()
    random = Math.floor(Math.random() * 6) + 1
    boards = store.makeList('board', random)
  teardown: ->
    Ember.run(App, 'destroy')
    Ember.run(testHelper, 'teardown')
})

test('Each board is displayed', ->
  visit("/boards")

  andThen ->
    boards.forEach (board) ->
      ok(find("div.board:contains('#{board.name}')"), "board for #{board.name} should exist")
)

test('click a board, visits that board', ->
  board = boards[0]

  visit("/boards")
  click("div.board:contains('#{board.name}')")

  andThen ->
    ok(find("div.board:contains('#{board.name}')"), "board for #{board.name} should exist")
    equal(find("div.board").length, 1, "only a single board should be displayed")
    equal(currentPath(), 'board', "path should be for board that was selected: #{board.name}")
    equal(currentURL(), "/boards/#{board.id}", "path should be for board that was selected: #{board.name}")
)
