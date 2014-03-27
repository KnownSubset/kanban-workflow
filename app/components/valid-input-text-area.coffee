`import KeyCodes from 'appkit/helpers/keyCodes'`
`import ValuePresence from 'appkit/mixins/presence'`
`import Validator from 'appkit/mixins/valid'`

ValidInputTextArea = Ember.TextArea.extend(ValuePresence, Validator);

`export default ValidInputTextArea`