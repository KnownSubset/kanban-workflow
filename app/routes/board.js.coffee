`import BasicRoute from 'appkit/routes/basic'`

BoardRoute = BasicRoute.extend({
  ###model: (parameters) ->
    board_id = parameters.board_id
    @get('store').find('board', board_id)###

  actions: {
    showCardDetails: (card) -> @showCardModal(@, 'card_display', card)
    closeModal: -> this.render('modal/hide_modal', {into: 'modal/modal', outlet: 'modalBody'})
  }
})

`export default BoardRoute`
