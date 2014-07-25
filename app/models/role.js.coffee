Role = DS.Model.extend({
  name: DS.attr('string'),
  description: DS.attr('string'),
  members: DS.hasMany('user', {async: true, inverse: 'roles'}),
  permissions: DS.hasMany('permission', {async: true, inverse: 'roles'}),
  userGroups: DS.hasMany('user-group', {async: true, inverse: 'roles'})
})

`export default Role`