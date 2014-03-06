`import BasicRoute from 'appkit/routes/basic'`

BoardsRoute = BasicRoute.extend({
  model: -> @get('store').findAll('board')
});
`export default BoardsRoute`
