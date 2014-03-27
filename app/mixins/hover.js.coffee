`import KeyCodes from 'appkit/helpers/keyCodes'`

Hover = Em.Mixin.create({
  isEditing: false,
  isEditable: false,
  model: null,

  click: () ->
    if @get('isEditable') then @set('isEditing', true)
  mouseEnter: () ->
    @set('isEditable', true)
  mouseLeave: () ->
    @set('isEditable', false) if not @isEditing
  keyDown: (e) ->
    switch e.keyCode
      when KeyCodes.escape, KeyCodes.enter, KeyCodes.tab
        @set('isEditable', false)
        @set('isEditing', false)

})

`export default Hover`