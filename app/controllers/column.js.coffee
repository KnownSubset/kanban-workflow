ColumnController = Ember.Controller.extend({

  moveCard: (card, oldSiblings, newSiblings) ->
    [column, store] = [@get('model'), @get('store')]
    oldSiblings.removeObject(card)
    newSiblings.pushObject(card)
    card.set('column', column)
    activity = "Card moved to #{Ember.get(column, 'name')}"
    record = store.createRecord('activityitem', {activity: activity, card: card})
    Ember.RSVP.all([record.save(), card.get('activityStream')]).then (promises) ->
      [activityItem, activityItems] = promises
      activityItems.pushObject(activityItem)

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

    dropped: (cards) ->
      [column, store] = [@get('model'), @get('store')]
      cards = (store.find('card', card) for card in cards)
      Em.RSVP.all([column.get('cards')].concat(cards)).then (promises) =>
        [newSiblings, cards...] = promises
        cards.get('firstObject.column').then (parentColumn) =>
          return if parentColumn.get('id') is column.get('id')
          parentColumn.get('cards').then (oldSiblings) =>
            @moveCard(card, oldSiblings, newSiblings) for card in cards
      false

  }
})

`export default ColumnController`
