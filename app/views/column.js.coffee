`import Droppable from 'appkit/mixins/droppable'`
`import Draggable from 'appkit/mixins/draggable'`

ColumnView = Ember.View.extend(Droppable, {
  templateName: 'column',
  classNames: ['column'],
  isDragging: (event) ->
    dropTarget = $(event.target).parents('.column.droppable')
    dropTargetIsCurrentView = not Ember.isBlank(dropTarget) and dropTarget.attr('id') is @get('elementId')
    dropTargetIsCurrentView and not Ember.isBlank($('div.card.dragged'))

})

`export default ColumnView`
