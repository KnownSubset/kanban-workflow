Invitation = DS.Model.extend({
  email: DS.attr('string'),
  pending: DS.attr('boolean'),
  directory: DS.belongsTo('directory', {async: true})
})

`export default Invitation`