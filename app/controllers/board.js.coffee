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
        .then((columns) -> columns.save())
        #.then -> board.save()
      false

    remove: ->
      @get('model').deleteRecord()

    addCard: ->
      board = @get('model')
      store = @get('store')
      columns = board.get('columns')
      firstCol = columns.get('firstObject')
      card = store.createRecord('card', {name: 'New Card', description: 'New Card', createdAt: new Date(), column: firstCol})
      card.save()
        .then -> firstCol.get('cards')
        .then((cards) ->
            cards.pushObject(card)
            card.set('column', firstCol)
          )
      false
  }
})

`export default BoardController`
