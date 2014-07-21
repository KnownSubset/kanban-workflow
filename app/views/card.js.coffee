`import Draggable from 'appkit/mixins/draggable'`

CardView = Ember.View.extend(Draggable, {
  templateName: 'card',
  classNameBindings: ['isDragging:dragged'],
  classNames: ['card'],
  isDragging: false
})

`export default CardView`
