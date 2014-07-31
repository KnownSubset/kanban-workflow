BoardController = Ember.Controller.extend({
  actions: {

    addColumn: ->
      board = @get('model')
      store = @get('store')
      column = store.createRecord('column', {name: 'column', kind:'manual', createdAt: new Date(), board: board})
      Em.RSVP.all([board.get('columns'), column.save()]).then (promises) ->
        [columns, column] = promises
        columns.pushObject(column)
      false

    remove: (column) ->
      board = @get('model')
      board.get('columns').then (columns)->
        columns.removeObject(column)
        column.deleteRecord()
        column.save()
      false

  }
})

`export default BoardController`
