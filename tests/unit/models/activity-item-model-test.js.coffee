`import { test, moduleFor, moduleForComponent, moduleForModel } from 'ember-qunit'`
`import Card from 'appkit/models/card'`
`import ActivityItem from 'appkit/models/activity-item'`

[store, activityItem, card, App, testHelper] = []

moduleForModel('activity-item', '', {
  setup: ->
    App = startApp()
    testHelper = Ember.Object.createWithMixins(FactoryGuyTestMixin).setup(App)
    store = testHelper.getStore()
    card = store.makeFixture('card')
    activityItem = store.makeFixture('activityItem', {card: card})

  teardown: ->
    Em.run(App, 'destroy')
    Em.run(testHelper, 'teardown')

})

test("ActivityItem is a valid ember-data Model", ->
  Em.run ->  store.find('activity-item', activityItem.id).then (item) ->
    ok(item)
    ok(item instanceof DS.Model)
    ok(item instanceof ActivityItem)
)

test("able to load the details for an activityitem", ->
  Em.run -> store.find('activity-item', activityItem.id).then (item) ->
    equal(item.get('activity'), activityItem.activity)
)

test("able to load the relationships for cards", ->
  Em.run -> store.find('activity-item', activityItem.id).then (item) ->
    Ember.RSVP.resolve(item.get('card'))
    .then (card) -> Ember.RSVP.resolve(card.get('activityStream'))

      .then (stream) ->
          ok(stream)
          ok(stream.isAny('activity', activityItem.activity))
          ok(stream.isAny('date', activityItem.date))
)

