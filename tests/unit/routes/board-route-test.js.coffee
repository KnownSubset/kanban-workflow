`import { test, moduleFor, moduleForComponent, moduleForModel } from 'ember-qunit'`
`import BoardRoute from 'appkit/routes/board'`

[store, testHelper, json] = []

moduleFor('route:board', "{{route:board}}", {
  needs: ['model:board', 'model:column', 'model:card']
  setup: (container) ->
    fixtureStore(container)
    testHelper = Ember.Object.createWithMixins(FactoryGuyTestMixin).setup({__container__: container})
    store = testHelper.getStore()
    json = store.makeFixture('board')
  teardown: ->
    Em.run(testHelper, 'teardown')
});

#TODO: updateActivity tests, show modal/close modal tests

test("it exists", ->
  route = this.subject()
  ok(route)
  ok(route instanceof Ember.Route)
  ok(route instanceof BoardRoute)
)

test("#model", ->
  route = this.subject({store: store})

  Em.run ->
    store.find('board', json.id).then (board) ->
      route.model({board_id: json.id}).then (model) ->
        deepEqual(board, model)
)

test("#model returns undefined if the param is not given", ->
  route = this.subject({store: store})
  Em.run ->
    ok(not route.model()?)
)
