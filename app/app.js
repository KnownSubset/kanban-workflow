import Resolver from 'ember/resolver';
import loadInitializers from 'ember/load-initializers';

Ember.ENV.RAISE_ON_DEPRECATION = true;
Ember.ENV.LOG_MODULE_RESOLVER = true;
Ember.ENV.LOG_STACKTRACE_ON_DEPRECATION = true;
Ember.ENV.LOG_ACTIVE_GENERATION = true;
Ember.ENV.LOG_TRANSITIONS = true;
Ember.ENV.LOG_TRANSITIONS_INTERNAL = true;
Ember.ENV.LOG_VIEW_LOOKUPS = true;

Ember.RSVP.configure('onerror', Ember.Logger.error);

var App = Ember.Application.extend({
  modulePrefix: 'appkit', // TODO: loaded via config
  Resolver: Resolver['default']
});

loadInitializers(App, 'appkit');


export default App;
