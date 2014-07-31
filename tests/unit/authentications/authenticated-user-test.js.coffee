`import LocalStorageHelper from 'appkit/helpers/local-storage'`
`import AuthenticatedUser from 'appkit/authentications/authenticated-user'`
`import Singleton from 'appkit/mixins/singleton'`
`import { test, moduleFor } from 'ember-qunit'`

moduleFor('authentication:authenticated-user', '{{authentication:authenticated-user}}', {
  setup: () ->
    LocalStorageHelper.set('current_user', {id: 1, email:'blah', token: 2, lastUpdated: 0})
  teardown: () ->
    LocalStorageHelper.set('current_user', null)
    AuthenticatedUser._current = null
})

test('an Authenticated user is an Ember.Object', () ->
  user = AuthenticatedUser.current()
  ok(user instanceof Ember.Object)
  ok(user instanceof AuthenticatedUser)
  ok(Singleton.detect(AuthenticatedUser))
)

test('calling create current returns the same instance of the logged in user', () ->
  user = AuthenticatedUser.current()
  propEqual(user, AuthenticatedUser.current())
  deepEqual(user, AuthenticatedUser.current())
)

test('saving an authenticated user will replace the instances that create current returns', () ->
  user = AuthenticatedUser.current()
  newEmail = 'lskdjfalsjfoiajfaiowjef'
  user.set('email', newEmail)

  user.save()
  AuthenticatedUser._current = null

  propEqual(user, AuthenticatedUser.current())
  deepEqual(user, AuthenticatedUser.current())
  equal(newEmail, AuthenticatedUser.current().get('email'))
)

test('logout will delete the current instance', () ->
  ic.ajax.defineFixture("#{ENV.organization_api}/logout", { response: {}, jqXHR: {}, textStatus: 'success' })
  user = AuthenticatedUser.current()

  user.logout().then ->

    equal(AuthenticatedUser._current, null)
)

test('logout will remove the token from the current instance, prior to deleting the current instance', () ->
  ic.ajax.defineFixture("#{ENV.organization_api}/logout", { response: {}, jqXHR: {}, textStatus: 'success' })
  user = AuthenticatedUser.current()
  token = user.get('token')
  user.ajax =  () -> Ember.RSVP.Promise.resolve(null)

  user.logout().then ->

    equal(user.get('token'), null)
    notEqual(user.get('token'), token)
)

test("a login attempt will return a RSVP.Promise", () ->
  LocalStorageHelper.set('current_user', null)
  AuthenticatedUser._current = null

  promise = AuthenticatedUser.login('roger@rabbit.com', 'roger')

  ok(promise instanceof Ember.RSVP.Promise)
)

test("a successful login attempt will save the user's token to current instance", () ->
  userData = {id: 1, email: 'roger@rabbit.com', token: 'token', lastUpdated: 0}
  ic.ajax.defineFixture("#{ENV.organization_api}/sessions.json", { response: userData, jqXHR: {}, textStatus: 'success' })
  LocalStorageHelper.set('current_user', null)
  AuthenticatedUser._current = null

  AuthenticatedUser.login('roger@rabbit.com', 'password').then ->

    propEqual(AuthenticatedUser.current(), userData)
)

test("calling refresh on AuthenticatedUser should cause last updated to change", () ->
  user = AuthenticatedUser.current()
  oldValue = user.lastUpdated

  AuthenticatedUser.refresh()

  newValue = user.lastUpdated
  notEqual(oldValue, newValue, "last updated should have changed")
)
