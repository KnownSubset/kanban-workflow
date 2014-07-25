ActivityItem = DS.Model.extend({
  card: DS.belongsTo('card', {async: true}),
  date: DS.attr('date'),
  activity: DS.attr('string')
})

`export default ActivityItem`
