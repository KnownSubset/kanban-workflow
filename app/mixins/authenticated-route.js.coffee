`import AuthenticatedUser from 'appkit/authentication/authenticated-user'`

AuthenticatedRoute = Ember.Mixin.create({
  beforeModel: (transition) ->
    user = AuthenticatedUser.current()
    if not user?
      loginController = this.controllerFor('modal/login')
      loginController.set('previousTransition', transition)
      @transitionTo('index').then (e) ->
        Ember.run.next -> e.send('showLogin')
})

`export default AuthenticatedRoute`
