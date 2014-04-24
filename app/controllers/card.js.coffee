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
      .then (column) ->
        card.destroyRecord()
        column.reload()

      #.then ((column) -> column.get('cards'))
      #  .then ((cards) -> cards.remove(card))
      #    .then -> column.save()
      false

    confirm: -> @get('model').save()
    undo: -> @get('model').rollback()
  }
})

`export default CardController`
