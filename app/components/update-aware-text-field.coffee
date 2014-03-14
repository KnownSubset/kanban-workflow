`import KeyCodes from 'appkit/helpers/keyCodes'`
`import ValidInputTextField from 'appkit/components/valid-input-text-field'`

UpdateAwareTextField = ValidInputTextField.extend({
  focusOut: () ->
    if @regex().test(this.$().val()) then @set('value', @originalValue)
    this.sendAction()

});

`export default UpdateAwareTextField`