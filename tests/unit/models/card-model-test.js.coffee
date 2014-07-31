`import { test, moduleForModel } from 'ember-qunit'`
`import Card from 'appkit/models/card'`

[card, App, testHelper, store] = []

moduleForModel('card', '', {

  setup: ->
    App = startApp()
    testHelper = Ember.Object.createWithMixins(FactoryGuyTestMixin).setup(App)
    store = testHelper.getStore()
    profile = store.makeFixture('profile')
    card = store.makeFixture('card', {assignee: profile.id})

  teardown: ->
    Em.run(App, 'destroy')
    Em.run(testHelper, 'teardown')

})

test("Card is a valid ember-data Model", ->
  Em.run ->  store.find('card', card.id).then (card) ->
    ok(card)
    ok(card instanceof DS.Model)
    ok(card instanceof Card)

)
