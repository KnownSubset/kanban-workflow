`import AuthenticatedRoute from 'appkit/mixins/authenticated-route'`
`import AuthenticatedUser from 'appkit/authentication/authenticated-user'`

BoardsRoute = Ember.Route.extend(AuthenticatedRoute, {
  model: ->
    @get('store').find('profile', AuthenticatedUser.current().id).then (profile) ->
      profile.get('boards')
})

`export default BoardsRoute`
