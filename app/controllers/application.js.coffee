`import Alertable from 'appkit/mixins/alertable'`
`import AuthenticatedUser from 'appkit/authentications/authenticated-user'`

ApplicationController = Ember.Controller.extend(Alertable, {
  actions: {
    logout: ->
      @get('model').logout().then(( ->
        @set('model',null)
        @transitionToRoute('index')
      ).bind(@)).catch(( -> @send('alert', {type: 'danger', message: "Unable to logout, please try again", fade: true, dismissAfter: 5}) ).bind(@))

  }
});
`export default ApplicationController`