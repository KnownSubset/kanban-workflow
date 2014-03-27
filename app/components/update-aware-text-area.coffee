`import KeyCodes from 'appkit/helpers/keyCodes'`
`import ValidInputTextArea from 'appkit/components/valid-input-text-area'`

UpdateAwareTextArea = ValidInputTextArea.extend({
  focusOut: () ->
    if @regex().test(this.$().val()) then @set('value', @originalValue)
    this.sendAction()

});

`export default UpdateAwareTextArea`