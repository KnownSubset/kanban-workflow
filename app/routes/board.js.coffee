`import BasicRoute from 'appkit/routes/basic'`

BoardRoute = BasicRoute.extend({
  ###model: (parameters) ->
    board_id = parameters.board_id
    @get('store').find('board', board_id)###
})

`export default BoardRoute`
