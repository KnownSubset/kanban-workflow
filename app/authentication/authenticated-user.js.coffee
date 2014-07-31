`import Singleton from 'appkit/mixins/singleton'`
`import LocalStorageHelper from 'appkit/helpers/local_storage'`

AuthenticatedUser = Ember.Object.extend({
  loggedIn: ( ->
    token = @get('token')
    token?
  ).property('token'),
  token: '',
  email: '',
  directory: '',
  lastUpdated: 0

  save: () ->
    LocalStorageHelper.set('current_user', @)
    AuthenticatedUser._current = @

  logout: ->
    user = @
    ic.ajax.request("#{ENV.organization_api}/logout", {
      data: { email: user.get('email'), token: user.get('token'), format: 'json' },
      type: 'DELETE',
      headers: {"X-AUTH-TOKEN": user.get('token')}
    }).then( ->
      user.set('token', null)
      LocalStorageHelper.set('current_user', null)
      AuthenticatedUser._current = null
    )
  updateUser: () ->
    console.log(@hasObserverFor('lastUpdated'))
    @set('lastUpdated', Date.now())
    @save()
})

AuthenticatedUser.reopenClass(Singleton, {
  createCurrent: () ->
    userJson = LocalStorageHelper.get('current_user')
    if userJson? then AuthenticatedUser.create(userJson) else null
  login: (email, password) ->
    ic.ajax.request("#{ENV.organization_api}/sessions.json", {
      data: { user: {email: email, password: password} },
      type: 'POST'
    }).then((result) ->
      user = AuthenticatedUser.create({id: result.id, email: email, token: result.token, lastUpdated: 0})
      user.save()
    )
  refresh: ()->
    current = @_current
    if current?
      current.updateUser()
  clear: ->
    LocalStorageHelper.set('current_user', null)
    @_current = null
})

`export default AuthenticatedUser`
