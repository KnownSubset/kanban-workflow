`import KeyCodes from 'appkit/helpers/keyCodes'`
`import ValuePresence from 'appkit/mixins/presence'`

ValidInputTextField = Ember.TextField.extend(ValuePresence, {
  classNameBindings: ['hasInvalidContent:invalid'],
  focused: false,
  hasInvalidContent: false,
  invalidPattern: null,
  originalValue: null,
  action: null,
  model: null,

  checkInputValueForInvalidContent : (->
    hasInvalidContent = @regex().test(@value)
    @set 'hasInvalidContent', hasInvalidContent
    false
  ).observes('value')
  didInsertElement: () ->
    this.$().focus() if @focused
    false
  focusOut: () ->
    if @hasInvalidContent then @sendAction('alert', {type: 'warning', message: "the input contains invalid characters"}) else @sendAction(@action)
    false

  init: () ->
    this._super()
    @originalValue = @value

  keyDown: (e) ->
    $control = this.$()
    switch e.keyCode
      when KeyCodes.escape
        @set('value', @originalValue)
        @model.save().then ->
          $control.blur()
      when KeyCodes.enter, KeyCodes.tab then $control.blur()

  regex: -> RegExp(@get('invalidPattern'))
});

`export default ValidInputTextField`