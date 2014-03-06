Presence = Em.Mixin.create({
  isBlank: (name) ->
    Ember.isEmpty(this[name] or this.get(name))
  isPresent: (name) ->
    return not this.isBlank(name)
});

`export default Presence`
