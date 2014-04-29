`import { test, moduleFor, moduleForComponent, moduleForModel } from 'ember-qunit'`
`import Column from 'appkit/models/column'`
`import Card from 'appkit/models/card'`
`import Board from 'appkit/models/board'`

#TODO: Update to use factory

moduleForModel('board', '', {
  needs: ['model:column','model:card'],
  setup: ->
    Board.FIXTURES = [{ id: 1, name: 'Board #1', description: 'Proin diam eros', createdAt: Date(), columns: [1, 2, 3] }]

    Column.FIXTURES = [
        {id:1, name: 'column #1_1', kind: 'manual', createdAt: Date(), cards: [], board: 1 },
        {id:2, name: 'column #1_2', kind: 'automated', createdAt: Date(), cards: [], board: 1 },
        {id:3, name: 'column #1_3', kind: 'manual', createdAt: Date(), cards: [], board: 1 }
        ]
})

test("Board is a valid ember-data Model", ->
  store = this.store()
  Em.run ->  store.find('board', 1).then (board) ->
    ok(board)
    ok(board instanceof DS.Model)
    ok(board instanceof Board)
)

test("able to load the details for a board", ->
  store = this.store()
  Em.run -> store.find('board', 1).then (board) ->
    fixture = Board.FIXTURES[0]
    equal(board.get('name'), fixture.name)
    equal(board.get('description'), fixture.description)
    equal(board.get('createdAt'), fixture.createdAt)
)

test("able to load the relationships for columns", ->
  store = this.store()
  Em.run -> store.find('board', 1).then (board) ->
    Ember.RSVP.resolve(board.get('columns'))
      .then (columns) -> Ember.RSVP.resolve(columns.get('firstObject').get('board'))

      .then (parent) ->
        ok(parent)
        equal( parent.get('id'), board.get('id') )
        ok(parent.get('name'))
        deepEqual(parent, board) if parent.get('name') #safeguard against test hanging
)
