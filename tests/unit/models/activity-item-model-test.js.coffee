`import { test, moduleFor, moduleForComponent, moduleForModel } from 'ember-qunit'`
`import Card from 'appkit/models/card'`
`import Activityitem from 'appkit/models/activityitem'`

#TODO: Update to use factory

moduleForModel('activityitem', '', {
  needs: ['model:card', 'model:board', 'model:column'],
  setup: ->
    Card.FIXTURES = [{
      id:1,
      name: 'card #1',
      activityStream: [1, 2]
    } ]
    Activityitem.FIXTURES = [{
      id: 1
      card: 1,
      date: Date.now(),
      activity: 'Card created'
    }, {
      id: 2
      card: 1,
      date: Date.now(),
      activity: 'Card edited'
    } ]
})

test("ActivityItem is a valid ember-data Model", ->
  store = this.store()
  Em.run ->  store.find('activityitem', 1).then (item) ->
    ok(item)
    ok(item instanceof DS.Model)
    ok(item instanceof Activityitem)
)

test("able to load the details for an activityitem", ->
  store = this.store()
  Em.run -> store.find('activityitem', 1).then (item) ->
    fixture = Activityitem.FIXTURES[0]
    equal(item.get('activity'), fixture.activity)
)

test("able to load the relationships for cards", ->
  store = this.store()
  Em.run -> store.find('activityitem', 1).then (item) ->
    Ember.RSVP.resolve(item.get('card'))
    .then (card) -> Ember.RSVP.resolve(card.get('activityStream'))

      .then (stream) ->
          ok(stream)
          fixture = Activityitem.FIXTURES[0]
          ok(stream.isAny('activity', fixture.activity))
          ok(stream.isAny('date', fixture.date))
)

