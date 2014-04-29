`import KeyCodes from 'appkit/helpers/keyCodes'`
`import Hover from 'appkit/mixins/hover'`

HoverAwareTextArea = Ember.Component.extend(Hover, {
  classNames: ["editable_text_area"],
  layoutName: "components/hover-aware-text-area",

});

`export default HoverAwareTextArea`