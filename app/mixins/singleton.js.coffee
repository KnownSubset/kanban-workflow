Singleton = Ember.Mixin.create({
  current: ->
    unless this._current then this._current = this.createCurrent() else this._current
  createCurrent: ->
    this.create {}
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
