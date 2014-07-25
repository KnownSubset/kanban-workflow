UserGroup = DS.Model.extend({
  name: DS.attr('string'),
  description: DS.attr('string', { default: "User Group description"} ),
  members: DS.hasMany('user', {async: true, inverse: 'userGroups'}),
  directory: DS.belongsTo('directory', {async: true, inverse: 'userGroups'}),
  roles: DS.hasMany('role', {async: true, inverse: 'userGroups' }),
  boards: DS.hasMany('boards', {async: true, inverse: 'userGroups' }),
})

`export default UserGroup`