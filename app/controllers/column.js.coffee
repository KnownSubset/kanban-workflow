ColumnController = Ember.Controller.extend({
  actions: {
    remove: ->
      column = @get('model')
      column.get('board').then (board) ->
        board.get('columns').then (columns)->
          columns.removeObject(column)
          column.deleteRecord()
      false

    addCard: ->
      column = @get('model')
      store = @get('store')
      card = store.createRecord('card', {name: 'New Card', description: 'New Card', createdAt: new Date(), column: column})
      Em.RSVP.all([column.get('cards'), card.save()]).then (promises) ->
        [cards, card] = promises
        cards.pushObject(card)
      false

    ###
    confirm: ->
      @get('model').save()
      false

    undo: ->
      @get('model').rollback()
      false
    ###

  }
})

`export default ColumnController`
