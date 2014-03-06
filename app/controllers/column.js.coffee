`import BasicController from 'appkit/controllers/basic'`

ColumnController = BasicController.extend({
  actions: {
    remove: ->
      column = @get('model')
      column.get('board')
        .then (board) -> board.get('columns').then (columns) ->
          columns.setObjects(columns.rejectBy('id', column.get('id')))
          board.save()
      column.deleteRecord()

    confirm: -> @get('model').save()
    undo: -> @get('model').rollback()
  }
})

`export default ColumnController`
