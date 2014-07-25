Permission = DS.Model.extend({
  name: DS.attr('string'),
  description: DS.attr('string'),
  active: DS.attr('boolean'),
  roles: DS.hasMany('role', {async: true, inverse: 'permissions'}),
  members: DS.hasMany('user', {async: true, inverse: 'permissions'}),
})

`export default Permission`