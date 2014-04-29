CardController = Ember.Controller.extend({
  description: ( ->
    text = @get('model.description') || ""
    if text.length > 30 then "#{text.substring(0,30)}..." else text
  ).property("model.description")

  actions: {
    remove: () ->
      model = @get('model')
      model.get('column').then (column) ->
        column.get('cards').then (cards)->
          cards.removeObject(model)
      model.deleteRecord()
      return

    confirm: -> @get('model').save()
    undo: -> @get('model').rollback()

  }
})

`export default CardController`
