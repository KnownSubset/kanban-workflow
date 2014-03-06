`import { test, moduleForRoute } from 'appkit/tests/helpers/module_for'`
`import Board from 'appkit/models/board'`
`import BasicRoute from 'appkit/routes/basic'`
`import BoardRoute from 'appkit/routes/board'`

moduleForRoute('board', "Unit - BoardRoute", {
  needs: ['model:board', 'model:column', 'model:card']
  setup: ->
    Board.FIXTURES = [ { id:1, name: 'Board #1', description: 'Proin.', createdAt: Date() } ]

});

test("it exists", ->
  route = this.subject()
  ok(route)
  ok(route instanceof BasicRoute)
  ok(route instanceof BoardRoute)
)

test("#model", ->
  store = this.store()
  route = this.subject({store: store})

  Em.run ->
    store.find('board', 1).then (board) ->
      route.model({board_id: 1}).then (model) ->
        deepEqual(board, model)
)

test("#model returns undefined if the param is not given", ->
  store = this.store()
  route = this.subject({store: store})
  Em.run ->
    ok(not route.model()?)
)
