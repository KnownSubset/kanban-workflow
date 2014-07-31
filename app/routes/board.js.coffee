`import AuthenticatedUser from 'appkit/authentications/authenticated-user'`
`import AuthenticatedRoute from 'appkit/mixins/authenticated-route'`

BoardRoute = Ember.Route.extend(AuthenticatedRoute, {
  model: (parameters) ->
    if parameters
      board_id = parameters.board_id
      @get('store').find('board', board_id)

  afterModel: (board, transition) ->
    unless board?
      @transitionTo('index').then (e) ->
        Ember.run.next -> e.send('showLogin')
    else
      authenicatedUser = AuthenticatedUser.current()
      store = @get('store')
      controller = @
      onRejection = (args) -> console.log(args); controller.transitionTo('index')
      board.get('members').then (members) ->
        store.find('profile',authenicatedUser.get('id')).then (user) ->
          controller.transitionTo('index') unless members.contains(user)
      .catch(onRejection)

  actions: {
    showCardDetails: (card) -> @send('showModal', 'card_display', card)
  }
})

`export default BoardRoute`
