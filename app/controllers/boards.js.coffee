BoardsController = Ember.ArrayController.extend({
  actions: {
    addBoard: ->
      boards = @get('model')
      store = @get('store')
      model = store.createRecord('board', {name: 'new board'})
      model.save().catch(Ember.Logger.error).then (board) -> boards.pushObject(board)
      false
  }
})

`export default BoardsController`
