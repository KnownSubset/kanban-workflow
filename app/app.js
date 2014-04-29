import Resolver from 'ember/resolver';
import Column from 'appkit/models/column';
import Card from 'appkit/models/card';
import Board from 'appkit/models/board';
import Activityitem from 'appkit/models/activityitem';

Ember.ENV.RAISE_ON_DEPRECATION = true;
Ember.ENV.LOG_MODULE_RESOLVER = true;
Ember.ENV.LOG_STACKTRACE_ON_DEPRECATION = true;
Ember.ENV.LOG_ACTIVE_GENERATION = true;
Ember.ENV.LOG_TRANSITIONS = true;
Ember.ENV.LOG_TRANSITIONS_INTERNAL = true;
Ember.ENV.LOG_VIEW_LOOKUPS = true;

var App = Ember.Application.extend({
  modulePrefix: 'appkit', // TODO: loaded via config
  Resolver: Resolver['default']
});

export default App;
