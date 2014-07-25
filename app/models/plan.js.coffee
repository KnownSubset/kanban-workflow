Plan = DS.Model.extend({
  name: DS.attr('string'),
  description: DS.attr('string'),
  cost: DS.attr('string'),
  capacity: DS.attr('number')
})

`export default Plan`