BoardRoute = Ember.Route.extend({
  model: (parameters) ->
    if parameters
      board_id = parameters.board_id
      @get('store').find('board', board_id)

  actions: {
    showCardDetails: (card) -> @send('showModal', 'card_display', card)
    closeModal: -> this.render('modal/hide_modal', {into: 'modal/modal', outlet: 'modalBody'})
  }
})

`export default BoardRoute`
