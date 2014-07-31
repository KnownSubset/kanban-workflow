`import { test, moduleFor, moduleForComponent, moduleForModel } from 'ember-qunit'`
`import AuthenticatedUser from 'appkit/authentication/authenticated-user'`
`import AuthenticatedRoute from 'appkit/mixins/authenticated-route'`
`import BoardRoute from 'appkit/routes/board'`

[store, testHelper, json] = []

moduleFor('route:board', "{{route:board}}", {
  needs: ['model:board', 'model:column', 'model:card','model:organization','model:directory','model:user-group','model:role','model:permission','model:account','model:user']
  setup: (container) ->
    App = startApp()
    testHelper = Ember.Object.createWithMixins(FactoryGuyTestMixin).setup(App)
    store = testHelper.getStore()
    route = @subject({store: store})
    user = store.makeFixture('profile')
    json = store.makeFixture('board', members: [user.id])
    AuthenticatedUser.create({id: user.id, token: 'token', lastUpdated: 0}).save()
    wait()
  teardown: ->
    Em.run(testHelper, 'teardown')
});

test("it exists", ->
  route = this.subject()
  ok(route)
  ok(route instanceof Ember.Route)
  ok(route instanceof BoardRoute)
  ok(AuthenticatedRoute.detect(route))
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
