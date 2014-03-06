Selection = Em.Mixin.create({
  isAnyItemSelected: false
  noItemSelected: true
  selectedItems: []
  isAnyItemSelectedObserver: (->
    itemSelected = @get('selectedItems.firstObject')?
    @set('isAnyItemSelected', itemSelected )
    @set('noItemSelected', not itemSelected )
    false
  ).observes('selectedItems')

  actions:
    selected: (item) ->
      if item.toggleProperty('isSelected')
        @set('selectedItems', @selectedItems.concat(item))
      else
        selectedElements = @selectedItems.filter (element) -> element isnt item
        @set('selectedItems', selectedElements)
});

`export default Selection`
