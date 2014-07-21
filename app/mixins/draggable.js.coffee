Draggable = Ember.Mixin.create({
  attributeBindings: ['draggable'],
  draggable: 'true',
  dragStart: (event) ->
    dataTransfer = event.originalEvent.dataTransfer
    event.dataTransfer.effectAllowed = "copyMove"
    event.dataTransfer.dropEffect = "copy"
    tacoData = this.get('controller.model.id')
    event.dataTransfer.setData('draggable.model.id', tacoData);
    Em.run => @set('isDragging', true)
  dragEnd: (event) ->
    Em.run => @set('isDragging', false)
})

`export default Draggable`