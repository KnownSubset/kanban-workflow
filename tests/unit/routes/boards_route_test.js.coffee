`import { test, moduleForRoute } from 'appkit/tests/helpers/module_for'`
`import Board from 'appkit/models/board'`
`import BasicRoute from 'appkit/routes/basic'`
`import BoardsRoute from 'appkit/routes/boards'`

moduleForRoute('boards', "Unit - BoardsRoute", {
  needs: ['model:board', 'model:column', 'model:card']
  setup: ->
    Board.FIXTURES = [ { id:1, name: 'Board #1', description: 'Proin.', createdAt: Date() } ]

});

test("it exists", ->
  route = this.subject()
  ok(route)
  ok(route instanceof BasicRoute)
  ok(route instanceof BoardsRoute)
)

test("#model", ->
  store = this.store()
  route = this.subject({store: store})

  Em.run ->
    store.findAll('board').then (boards) ->
      route.model().then (model) ->
        deepEqual(boards, model)
)
