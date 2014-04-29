BoardsRoute = Ember.Route.extend({
  model: -> @get('store').findAll('board')
});
`export default BoardsRoute`
