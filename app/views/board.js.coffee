`import Droppable from 'appkit/mixins/droppable'`

BoardView = Ember.View.extend({
  templateName: 'board',
  classNames: ['board'],
  isDragging: (event) ->
    dragging = event.target
    dropping = event.currentTarget
    dragging.classList.contains('column') && dropping.classList.contains('board')


})

`export default BoardView`
