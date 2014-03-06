var Router = Ember.Router.extend(); // ensure we don't share routes between all Router instances

Router.map(function() {
  this.route('component-test');
  this.route('helper-test');

  this.resource('boards');
  this.resource('board', { path: '/board/:board_id' });
});

export default Router;
