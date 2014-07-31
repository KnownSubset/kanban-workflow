Organization = DS.Model.extend({
  name: DS.attr('string'),
  description: DS.attr('string'),
  directories: DS.hasMany('directory', {async: true})
  boards: DS.hasMany('board', {async: true})
})

`export default Organization`