directory = DS.Model.extend({
  name: DS.attr('string'),
  description: DS.attr('string'),
  members: DS.hasMany('user', {async: true, inverse: 'directories'}),
  organization: DS.belongsTo('organization', {async: true, inverse: 'directories'}),
  userGroups: DS.hasMany('user-group', {async: true, inverse: 'directory'}),
  invitations: DS.hasMany('invitation', { async: true, inverse: 'directory' })
})

`export default directory`