LocalStorageHelper = Ember.create({
  set: (key, value) ->
    localStorage["FullConnect.#{key}"]=JSON.stringify(value)
  get: (key) ->
    value = localStorage["FullConnect.#{key}"]
    JSON.parse(value) if value?
  clear: () ->
    localStorage.clear();
})
`export default LocalStorageHelper`