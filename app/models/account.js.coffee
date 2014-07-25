Account = DS.Model.extend({
  user: DS.belongsTo('user', {async: true}),
  organization: DS.belongsTo('organization', {async: true}),
  plan: DS.belongsTo('plan', {async: true}),
  email: DS.attr('string'),
  customerId: DS.attr('string'),
  spaceUsed: DS.attr('number')
})

`export default Account`