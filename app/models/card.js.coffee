`import Presence from 'appkit/mixins/presence'`

Card = DS.Model.extend(Presence, {
  column: DS.belongsTo('column', {async: true}),
  name: DS.attr('string'),
  description: DS.attr('string'),
  createdAt: DS.attr('date'),
  comments: DS.attr('string')
})

`export default Card`
