fixtureStore = (container) ->
  return if container.cache.has(container.normalize('store:main'))
  container.register('store:main', DS.Store)
  container.register('serializer:application', DS.JSONSerializer)
  container.register('adapter:application', DS.FixtureAdapter)
  container.register('transform:boolean', DS.BooleanTransform)
  container.register('transform:date', DS.DateTransform)
  container.register('transform:number', DS.NumberTransform)
  container.register('transform:string', DS.StringTransform)
  container.injection('route', 'store', 'store:main')
  container.injection('model', 'store', 'store:main')
  container.lookup('store:main')

`export default fixtureStore`