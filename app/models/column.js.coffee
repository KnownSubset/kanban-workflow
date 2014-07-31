Column = DS.Model.extend({
  name: DS.attr('string'),
  kind: DS.attr('string'),
  createdAt: DS.attr('date'),
  cards: DS.hasMany('card', {async: true}),
  board: DS.belongsTo('board', {async: true}),
})

`export default Column`
