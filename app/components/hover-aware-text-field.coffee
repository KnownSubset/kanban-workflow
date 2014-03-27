`import KeyCodes from 'appkit/helpers/keyCodes'`
`import Hover from 'appkit/mixins/hover'`

HoverAwareTextField = Ember.Component.extend(Hover, {
  classNames: ["editable_text_field"],
  layoutName: "hover-aware-text-field",

});

`export default HoverAwareTextField`