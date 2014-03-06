`import BasicController from 'appkit/controllers/basic'`

CardController = BasicController.extend({
  description: ( ->
    text = @get('model.description') || ""
    if text.length > 30 then "#{text.substring(0,30)}..." else text
  ).property("model.description")
  actions: {
    remove: () ->
      card = @get('model')
      card.get('column')
        .then (column) -> column.get('cards').then (cards) ->
          cards.setObjects(cards.rejectBy('id', card.get('id')))
          column.save()
      card.deleteRecord()
  }
})

`export default CardController`
