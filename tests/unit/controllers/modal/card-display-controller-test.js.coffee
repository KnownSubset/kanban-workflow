`import { test, moduleFor } from 'ember-qunit'`
`import AuthenticatedUser from 'appkit/authentications/authenticated-user'`

[controller, store, App, card, column, testHelper, member] = []

moduleFor("controller:modal/card-display", "Modal - Card Display Controller", {
  needs: ['controller:modal']
  setup: ->
    App = startApp()
    testHelper = Ember.Object.createWithMixins(FactoryGuyTestMixin).setup(App)
    store = testHelper.getStore()
    controller = @subject({store: store})
    member = store.makeFixture('profile')
    board = store.makeFixture('board', {members: [member.id]})
    column = store.makeFixture('column', {board: board})
    card = store.makeFixture('card', {column: column})
    AuthenticatedUser.create({id: member.id, email: 'fake@user.com', token: 'token', lastUpdated: 0}).save()
    Em.run -> Em.RSVP.all([store.find('card', card.id), store.find('column', column.id)]).then (items) ->
      [card, column] = items
      controller.set('model', card)
    wait()
  teardown: ->
    Em.run(App, 'destroy')
    Em.run(testHelper, 'teardown')
})

test("Removing a card deletes it from the store", ->
  Em.run -> controller.send('remove')

  andThen ->
    ok(card.get('isDirty'), 'the card should be marked for deletion, but we can still access it until we call card.save()')
    ok(card.get('isDeleted'), 'the card should be marked for deletion, but we can still access it until we call card.save()')
)

test("Archiving a card adds an activity item to the store", ->
  Em.run ->
    controller.send('archive')
    wait()

  andThen ->
    ok(card.get('archived'), 'the card should be archived')
    card.get('activityStream').then (stream) ->
      equal(stream.get('length'), 1, 'A new activity should have been added')
      activity = stream.get('lastObject')
      equal(activity.get('activity'), "Card was archived!", 'The card activity should be "Card was archived!"')
      activity.get('actor').then (actor) ->
        equal(actor.get('id'), member.id, "Should have been archived by #{member.id}")
)

test("Removing a card removes it from the column it belongs to", ->
  Em.run -> controller.send('remove')

  andThen ->
    column.get('cards').then (cards) ->
      equal(cards.get('length'), 0, 'the only card should have been removed')
      ok(card.get('isDeleted'), 'the only card should have been removed')
)

test("Updating a card adds an activityItem", ->
  Em.run ->
    card.set('name', "asdfasdf")
    card.set('description', "asdfasdf")

    controller.send('save')
    wait()

  andThen ->
    card.get('activityStream').then (stream) ->
      equal(stream.get('length'), 1, 'A new activity should have been added')
      activity = stream.get('lastObject')
      equal(activity.get('activity'), "Updated: name, description", 'The card activity should say that the card name & description were updated')
      activity.get('actor').then (actor) ->
        equal(actor.get('id'), member.id, "Should have been updated by #{member.id}")
)

test("Save button is not enabled until something changes", ->
  Em.run ->
    ok(controller.get('disableSubmit') )
    card.set('name', "asdfasdf")
    ok(not controller.get('disableSubmit') )

    card.rollback()
    ok(controller.get('disableSubmit') )
    card.set('description', "asdfasdf")
    ok(not controller.get('disableSubmit') )

    card.rollback()
    ok(controller.get('disableSubmit') )
    controller.set('comments', "asdfasdf")
    ok(not controller.get('disableSubmit') )
)

test("Saving a card without updating does not add an activityItem", ->
  Em.run ->
    controller.send('save')
    wait()

  andThen ->
    card.get('activityStream').then (stream) ->
      equal(stream.get('length'), 0, 'A new activity should NOT have been added')
)

test("User can add comments to a card by adding an activityItem", ->
  Em.run ->
    controller.set('comments', "asdfasdf")

    controller.send('save')
    wait()

  andThen ->
    card.get('activityStream').then (stream) ->
      equal(stream.get('length'), 1, 'A new activity should have been added')
      activity = stream.get('lastObject')
      equal(activity.get('activity'), "Commented: asdfasdf", 'The comments should have been added via card activities')
      activity.get('actor').then (actor) ->
        equal(actor.get('id'), member.id, "Should have been updated by #{member.id}")
)

test("Reassigning a card adds an activityItem", ->
  profile = null
  Em.run ->
    store.find('profile', member.id).then (member) -> profile = member
  wait()

  andThen -> controller.send('reassign', profile)

  andThen ->
    card.get('activityStream').then (stream) ->
      equal(stream.get('length'), 1, 'A new activity should have been added')
      profile.get('user').then (user) ->
        activity = stream.get('lastObject')
        equal(activity.get('activity'), "Re-assigned to #{user.get('email')}", "Re-assigned to #{user.get('email')} was not found")
        activity.get('actor').then (actor) ->
          equal(actor.get('id'), member.id, "Re-assigned to #{user.get('email')} was not found")
)

test("Reassigning a card sets the user as the assignee of the card", ->
  user = null
  Em.run ->
    store.find('profile', member.id).then (member) -> user = member
  wait()

  andThen -> controller.send('reassign', user)

  andThen ->
    card.get('assignee').then (assignee) ->
      equal(assignee.get('id'), user.get('id'), 'The card was not reassigned')
)

test("Cancelling out will revert the card", ->
  Em.run ->
    card.set('name', "asdfasdf")
    card.set('description', "asdfasdf")

    controller.send('cancel')
    wait()

  andThen ->
    ok(not card.get('isDirty'), 'card should be reverted')
    notEqual(card.get('description'), "asdfasdf", 'card should be reverted')
)
