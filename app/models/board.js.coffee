`import Presence from 'appkit/mixins/presence'`

Board = DS.Model.extend(Presence, {
  name: DS.attr('string'),
  description: DS.attr('string'),
  createdAt: DS.attr('date'),
  columns: DS.hasMany('column', {async: true}),
#owner: DS.belongsTo('user', {async: true}),
})

`export default Board`
