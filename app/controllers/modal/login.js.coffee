`import AuthenticatedUser from 'appkit/authentication/authenticated-user'`
`import LocalStorageHelper from 'appkit/helpers/local_storage'`

LoginController = Ember.Controller.extend({
  needs: ['application'],
  loggingIn: false,
  title: 'Login',

  loginButtonText: ( ->
    if @get('loggingIn') then 'Signing In...' else 'Sign in'
  ).property('loggingIn'),

  loginDisabled: ( ->
    @get('loggingIn') or Ember.isBlank(@get('email')) or Ember.isBlank(@get('password'))
  ).property('email', 'password', 'loggingIn'),
  
  loginSuccessful: () ->
    @get('controllers.application').set('model', AuthenticatedUser.current())
    @set('loggingIn', false)
    previousTransition = @get('previousTransition')
    if (previousTransition)
      @set('previousTransition', null)
      previousTransition.retry()
    else
      this.transitionToRoute('boards')
    @send('closeModal')

  loginFailed: (error) ->
    @set('loggingIn', false)
    response = $.parseJSON(error.jqXHR.responseText)
    @send('alert', {type: 'warning', message: response.message})

  actions: {
    login: ->
      if @get('loginDisabled') then return
      @set('loggingIn', true)
      onFulfillment = @loginSuccessful.bind(@)
      onRejection = @loginFailed.bind(@)
      AuthenticatedUser.login(@get('email'), @get('password')).then(onFulfillment).catch(onRejection)
      false
  }
})

`export default LoginController`
