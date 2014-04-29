Card = DS.Model.extend({
  column: DS.belongsTo('column', {async: true}),
  name: DS.attr('string'),
  archived: DS.attr('boolean', {defaultValue: false}),
  description: DS.attr('string'),
  createdAt: DS.attr('date'),
  comments: DS.attr('string'),
  activityStream: DS.hasMany('activityitem', {async: true})
})

`export default Card`
