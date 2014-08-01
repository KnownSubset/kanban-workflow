Card = DS.Model.extend({
  assignee: DS.belongsTo('profile', { async: true }),
  column: DS.belongsTo('column', {async: true}),
  name: DS.attr('string'),
  archived: DS.attr('boolean', {defaultValue: false}),
  description: DS.attr('string'),
  createdAt: DS.attr('date'),
  activityStream: DS.hasMany('activity-item', {async: true})
})

`export default Card`
