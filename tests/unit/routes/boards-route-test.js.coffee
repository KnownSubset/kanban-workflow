`import { test, moduleFor } from 'ember-qunit'`
`import Board from 'appkit/models/board'`
`import BoardsRoute from 'appkit/routes/boards'`

[App, store, testHelper, json] = []

moduleFor('route:boards', "{{route:boards}}", {
  needs: ['model:board', 'model:column', 'model:card']
  setup: (container) ->
    fixtureStore(container)
    testHelper = Ember.Object.createWithMixins(FactoryGuyTestMixin).setup({__container__: container})
    store = testHelper.getStore()
    json = store.makeList('board', Math.floor(Math.random() * 6) + 1)
  teardown: ->
    Em.run(testHelper, 'teardown')

});

test("it exists", ->
  route = @subject()
  ok(route)
  ok(route instanceof Ember.Route)
  ok(route instanceof BoardsRoute)
)

test("#model", ->
  route = @subject({store: store})

  Em.run ->
    store.findAll('board').then (boards) ->
      route.model().then (model) ->
        equal(boards.get('length'), json.length, 'should be the same length')
        deepEqual(boards, model)
)
