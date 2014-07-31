`import { test, moduleFor } from 'ember-qunit'`
`import Board from 'appkit/models/board'`
`import BoardsRoute from 'appkit/routes/boards'`
`import AuthenticatedUser from 'appkit/authentication/authenticated-user'`
`import AuthenticatedRoute from 'appkit/mixins/authenticated-route'`

[App, store, testHelper, json] = []

moduleFor('route:boards', "{{route:boards}}", {
  setup: (container) ->
    App = startApp()
    testHelper = Ember.Object.createWithMixins(FactoryGuyTestMixin).setup(App)
    store = testHelper.getStore()
    user = store.makeFixture('profile')
    json = store.makeList('board', Math.floor(Math.random() * 6) + 1, {members: [user.id]})
    user.boards = json.mapBy('id')
    store.makeList('board', Math.floor(Math.random() * 6) + 1)
  teardown: ->
    Ember.run(App, 'destroy')
    Em.run(testHelper, 'teardown')

})

test("it exists", ->
  route = @subject()
  ok(route)
  ok(route instanceof Ember.Route)
  ok(route instanceof BoardsRoute)
  ok(AuthenticatedRoute.detect(route))
)

test("model only returns the current user's boards", ->
  route = @subject({store: store})

  Em.run ->
    promises = (store.find('board', board.id) for board in json)
    Em.RSVP.all(promises).then (boards) ->
      route.model().then (model) ->
        equal(boards.get('length'), json.length, 'should be the same length')
        deepEqual(boards.mapBy('id'), model.mapBy('id'))
)
