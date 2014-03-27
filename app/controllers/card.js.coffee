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

      #Commenting this out because I'm not convinced it is entirely necessary
      #Deleting the card seems to handle this just fine. Leaving it in so that it can be reviewed in case I'm missing
      #something -DS.

      #  .then (column) -> column.get('cards').then (cards) ->
      #    cards.setObjects(cards.rejectBy('id', card.get('id')))
      #    column.save()

      card.deleteRecord()

    confirm: -> @get('model').save()
    undo: -> @get('model').rollback()
  }
})

`export default CardController`
