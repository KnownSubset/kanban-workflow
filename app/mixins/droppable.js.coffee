
Droppable = Em.Mixin.create({
  classNames: ['droppable']
  isDragging: Ember.required(Function)
  createDropEffect: (event, isDragging) ->
    if event.dataTransfer?
      event.dataTransfer.dropEffect = if isDragging then 'copy' else 'none'

  dragEnter: (event) ->
    event.stopPropagation()
    event.preventDefault()
    @set('controller.isDragging', true)
    @createDropEffect(event, true)
    return
  dragOver: (event) ->
    event.stopPropagation()
    event.preventDefault()
    @set('controller.isDragging', true)
    @createDropEffect(event, true)
    return
  dragLeave: (event) ->
    event.stopPropagation()
    event.preventDefault()
    dragging = @isDragging(event)
    Ember.run (-> @set('controller.isDragging', dragging)).bind(@)
    @createDropEffect(event, dragging)
    return
  drop: (event) ->
    event.stopPropagation()
    event.preventDefault()
    return false unless @get('controller.isDragging')
    models = event.dataTransfer.getData('draggable.model.id')
    @get('controller').send('dropped', [models])
    Ember.run (-> @set('controller.isDragging', false)).bind(@)
    @createDropEffect(event, false)
    return
})

`export default Droppable`