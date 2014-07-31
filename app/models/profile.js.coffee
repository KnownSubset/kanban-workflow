Profile = DS.Model.extend({
  email: Em.computed('user', -> @get('user').then (user) -> user.get('email') ),
  imageUrl: Em.computed('user', -> @get('user').then (user) -> user.get('imageUrl')),
  boards: DS.hasMany('board', { async: true, inverse: 'members' }),
  user: DS.belongsTo('user', { async: true }),
})

`export default Profile`