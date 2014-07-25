Card = DS.Model.extend({
  assignee: DS.belongsTo('user', { async: true }),
  column: DS.belongsTo('column', {async: true}),
  name: DS.attr('string'),
  archived: DS.attr('boolean', {defaultValue: false}),
  description: DS.attr('string'),
  createdAt: DS.attr('date'),
  comments: DS.attr('string'),
  activityStream: DS.hasMany('activity-item', {async: true})
})

`export default Card`
