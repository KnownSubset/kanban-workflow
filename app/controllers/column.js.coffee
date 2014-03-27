`import BasicController from 'appkit/controllers/basic'`

ColumnController = BasicController.extend({
  actions: {
    remove: ->
      column = @get('model')

      #I'm not convinced that we need this. See Card controller for an explanation. -DS
#      column.get('board')
#        .then (board) -> board.get('columns').then (columns) ->
#          columns.setObjects(columns.rejectBy('id', column.get('id')))
#          board.save()
      column.deleteRecord()

    confirm: -> @get('model').save()
    undo: -> @get('model').rollback()
  }
})

`export default ColumnController`
