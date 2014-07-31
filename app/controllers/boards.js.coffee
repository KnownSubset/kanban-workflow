`import AuthenticatedUser from 'appkit/authentications/authenticated-user'`

BoardsController = Ember.ArrayController.extend({
  actions: {
    addBoard: ->
      boards = @get('model')
      store = @get('store')
      model = store.createRecord('board', {name: 'new board'})
      model.save()
        .then (board) ->
          user = AuthenticatedUser.current()
          boards.pushObject(board)
          Em.RSVP.all([store.find('profile',user.id), board.get('members')])
        .then (promises) ->
          [profile, members] = promises
          members.pushObject(profile)
        .catch(Ember.Logger.error)
      false
  }
})

`export default BoardsController`
