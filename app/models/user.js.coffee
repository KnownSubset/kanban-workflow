User = DS.Model.extend({
  email: DS.attr('string'),
  account: DS.belongsTo('account', { async: true }),
  directories: DS.hasMany('directory', { async: true, inverse: 'members' }),
  userGroups: DS.hasMany('user-group', { async: true, inverse: 'members' }),
  roles: DS.hasMany('roles', { async: true, inverse: 'members' }),
  permissions: DS.hasMany('permission', { async: true, inverse: 'members' }),
  boards: DS.hasMany('board', { async: true, inverse: 'owner' }),
})

`export default User`