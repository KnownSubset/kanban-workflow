`import BoardsController from 'appkit/controllers/boards'`
`import factories from 'appkit/tests/factories/domain'`
`import { test, moduleFor } from 'ember-qunit'`

[controller, store, App, board, testHelper] = []

moduleFor('controller:boards', '{{controller:boards}}', {

  setup: ->
    App = startApp()
    testHelper = Ember.Object.createWithMixins(FactoryGuyTestMixin).setup(App)
    store = testHelper.getStore()
    controller = @subject({store: store})
    random = Math.floor(Math.random() * 6) + 1
    store.makeList('board', random)
    Em.run -> store.findAll('board').then (boards) -> controller.set('model', boards)

  teardown: ->
    Ember.run(testHelper, 'teardown')
    Ember.run(App, 'destroy')
})

test("should be a extension of the Basic controller", () ->
  andThen ->
    ok(controller)
    ok(controller instanceof Ember.ArrayController)
    ok(controller instanceof BoardsController)
)

test("Should be able to add a board and have it save the new column out",  () ->
  andThen -> Em.run -> controller.send('addBoard')

  andThen ->
    newBoard = controller.get('model').findBy('name', 'new board')
    ok(newBoard, 'should have found the new board')
    ok(not newBoard.get('isDirty'), 'The created board should be saved')
    ok(not newBoard.get('isNew'), 'The created board should be saved')

)

### TODO: fix this test
asyncTest("Removing a board marks the model for deletion", 4, () ->
  Em.run -> store.createRecord('board', { name: 'Board #1', description: 'Lorem Ipsum', createdAt: Date() }).save()
    .then (board) ->
      ok(not board.get('isDirty'))
      ok(not board.get('isDeleted'))
      controller.set('model', board)
      controller.send('remove')

  wait()

  andThen ->
    Em.run -> store.find('board','fixture-0').then (board) ->
      ok(board.get('isDirty'))
      ok(board.get('isDeleted'), 'the board should be marked for deletion, but we can rollback until we call board.save()')
      start()
)

###