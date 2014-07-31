ActivityItem = DS.Model.extend({
  card: DS.belongsTo('card', {async: true}),
  date: DS.attr('date'),
  actor: DS.belongsTo('profile', {async: true})
  activity: DS.attr('string')
})

`export default ActivityItem`
