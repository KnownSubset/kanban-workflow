`import ColumnController from 'appkit/controllers/column'`
`import factories from 'appkit/tests/factories/domain'`
`import { test, moduleFor } from 'ember-qunit'`

[controller, store, App, board, column, testHelper, model] = []

moduleFor('controller:column', '{{controller:column}}', {

  setup: ->
    App = startApp()
    testHelper = Ember.Object.createWithMixins(FactoryGuyTestMixin).setup(App)
    store = testHelper.getStore()
    controller = @subject({store: store})
    board = store.makeFixture('board')
    column = store.makeFixture('column', {board: board})
    card = store.makeFixture('card', {column: column})
    Em.run ->
      store.find('column', column.id).then (column) ->
        model = column
        controller.set('model', model)
    wait()

  teardown: ->
    Ember.run(App, 'destroy')
    Ember.run(testHelper, 'teardown')

})

test("should be a extension of the Ember.Controller", () ->
  ok(controller)
  ok(controller instanceof Ember.Controller)
  ok(controller instanceof ColumnController)
)

test("Removing a column deletes it from the store", () ->
  andThen -> Em.run -> controller.send('remove')

  andThen ->
    ok(model.get('isDirty'))
    ok(model.get('isDeleted'), "the column should be marked for deletion, but we can still access it until we call column.save()")
)
