BoardsController = Ember.ArrayController.extend({
  actions: {
    addBoard: ->
      boards = @get('model')
      store = @get('store')
      board = store.createRecord('board', {name: 'new board',createdAt: new Date()})
      board.save()
        .catch(Ember.Logger.error)
        .then (board) ->
          boards.pushObject(board)
      false

    remove: ->
      @get('model').deleteRecord()
  }
})

`export default BoardsController`
