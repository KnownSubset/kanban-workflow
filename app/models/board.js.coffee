Board = DS.Model.extend({
  name: DS.attr('string'),
  description: DS.attr('string'),
  createdAt: DS.attr('date'),
  columns: DS.hasMany('column', {async: true}),
  organization: DS.belongsTo('organization', {async: true}),
  members: DS.hasMany('user', {async: true, inverse: 'boards'}),
  userGroups: DS.hasMany('user-group', { async: true, inverse: 'boards' }),
})

`export default Board`
