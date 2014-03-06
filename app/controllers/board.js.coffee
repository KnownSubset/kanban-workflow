`import Column from 'appkit/models/column'`
`import BasicController from 'appkit/controllers/basic'`

BoardController = BasicController.extend({
  actions: {
    addColumn: ->
      board = @get('model')
      store = @get('store')
      column = store.createRecord('column', {name: 'column', kind:'manual',createdAt: new Date(), board: board})
      column.save()
        .then -> board.get('columns')
        .then((columns) -> columns.pushObject(column))
        #.then -> board.save()
      false

    remove: ->
      @get('model').deleteRecord()
  }
})

`export default BoardController`
