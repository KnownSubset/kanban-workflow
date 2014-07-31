`import { test, moduleFor, moduleForComponent, moduleForModel } from 'ember-qunit'`
`import Board from 'appkit/models/board'`

[store, columns, board, App, testHelper] = []

moduleForModel('board', '', {
  setup: ->
    App = startApp()
    testHelper = Ember.Object.createWithMixins(FactoryGuyTestMixin).setup(App)
    store = testHelper.getStore()
    board = store.makeFixture('board')
    columns = store.makeList('column', 3, {board: board})
    board.columns = columns.mapBy('id')

  teardown: ->
    Em.run(App, 'destroy')
    Em.run(testHelper, 'teardown')
})

test("Board is a valid ember-data Model", ->
  Em.run ->  store.find('board', 1).then (board) ->
    ok(board)
    ok(board instanceof DS.Model)
    ok(board instanceof Board)
)

test("able to load the details for a board", ->
  Em.run -> store.find('board', board.id).then (board) ->
    fixture = Board.FIXTURES[0]
    equal(board.get('name'), fixture.name)
    equal(board.get('description'), fixture.description)
    equal(board.get('createdAt'), fixture.createdAt)
)

test("able to load the relationships for columns", ->
  Em.run -> store.find('board', board.id).then (board) ->
    Ember.RSVP.resolve(board.get('columns'))
      .then (columns) -> Ember.RSVP.resolve(columns.get('firstObject').get('board'))

      .then (parent) ->
        ok(parent)
        equal( parent.get('id'), board.get('id') )
        ok(parent.get('name'))
        deepEqual(parent, board) if parent.get('name') #safeguard against test hanging
)
