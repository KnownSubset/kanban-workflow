`import Droppable from 'appkit/mixins/droppable'`
`import Draggable from 'appkit/mixins/draggable'`

ColumnView = Ember.View.extend(Droppable, {
  templateName: 'column',
  classNames: ['column'],
  isDragging: (event) ->
    dropTarget = $(event.target).parents('.column.droppable')
    dropTargetIsCurrentView = dropTarget.length is 1 and dropTarget.attr('id') is @get('elementId')
    dropTargetIsCurrentView and $('div.card.dragged').length is 1

})

`export default ColumnView`
