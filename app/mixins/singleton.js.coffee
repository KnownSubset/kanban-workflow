Singleton = Ember.Mixin.create({
  current: () ->
    this._current = this.createCurrent() unless this._current?
    this._current
  createCurrent:  -> this.create({})
  currentProp: (property, value) ->
    instance = this.current()
    if not instance? then return
    if (value?)
      instance.set(property, value)
      return value
    else
      return instance.get(property)
});

`export default Singleton`
