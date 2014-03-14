`import KeyCodes from 'appkit/helpers/keyCodes'`

HoverAwareTextField = Ember.Component.extend({
  classNames: ["editable_text_field"],
  layoutName: "hover-aware-text-field",
  isEditing: false,
  isEditable: false,
  model: null,
  board: null,

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

});

`export default HoverAwareTextField`