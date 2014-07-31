`import { test, moduleForModel } from 'ember-qunit'`
`import Column from 'appkit/models/column'`

[column, App, testHelper, store] = []

moduleForModel('column', '', {
  setup: ->
    App = startApp()
    testHelper = Ember.Object.createWithMixins(FactoryGuyTestMixin).setup(App)
    store = testHelper.getStore()
    board = store.makeFixture('board')
    column = store.makeFixture('column', {board: board.id})
    cards = store.makeList('card', 3, {column: column.id})
    column.cards = cards.mapBy('id')
    board.columns = [column.id]

  teardown: ->
    Em.run(App, 'destroy')
    Em.run(testHelper, 'teardown')
})

test("Column is a valid ember-data Model", ->
  Em.run ->  store.find('column', column.id).then (column) ->
    ok(column)
    ok(column instanceof DS.Model)
    ok(column instanceof Column)
)

test("able to load the details for a column", ->
  Em.run -> store.find('column', column.id).then (model) ->
    equal(model.get('name'), column.name)
    equal(model.get('kind'), column.kind)
    equal(model.get('createdAt'), column.createdAt)
)

test("able to load the relationships for cards", ->
  Em.run -> store.find('column', column.id).then (column) ->
    Ember.RSVP.resolve(column.get('cards'))
      .then (cards) -> Ember.RSVP.resolve(cards.get('firstObject').get('column'))

      .then (parent) ->
        ok(parent)
        equal( parent.get('id'), column.get('id') )
        ok(parent.get('name'))
        deepEqual(parent, column) if parent.get('name') #safeguard against test hanging
)
