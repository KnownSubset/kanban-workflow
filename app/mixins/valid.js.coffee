`import KeyCodes from 'appkit/helpers/keyCodes'`

Valid = Ember.Mixin.create({
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
        #@get('model').save().then ->
        $control.blur()
      when KeyCodes.enter, KeyCodes.tab then $control.blur()

  regex: -> RegExp(@get('invalidPattern'))
  })

`export default Valid`