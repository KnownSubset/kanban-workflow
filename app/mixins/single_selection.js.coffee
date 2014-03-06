`import Selection from 'appkit/mixins/selections'`

SingleSelection = Em.Mixin.create(Selection, {
  selectedItem: (-> @get('selectedItems.firstObject')).property('selectedItems')

  actions:
    selected: (item) ->
      if item.toggleProperty('isSelected')
        selectedItem = @get('selectedItem')
        selectedItem.toggleProperty('isSelected') if selectedItem?
        @set('selectedItems', [item])
      else
        @set('selectedItems', [])
});

`export default SingleSelection`
