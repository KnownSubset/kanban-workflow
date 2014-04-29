# ensure we don't share routes between all Router instances
Router = Ember.Router.extend()

Router.map( ->
  this.resource('boards')
  this.resource('board', {path: 'boards/:board_id'})

)

`export default Router`
