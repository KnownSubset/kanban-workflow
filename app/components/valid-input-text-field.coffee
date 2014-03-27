`import KeyCodes from 'appkit/helpers/keyCodes'`
`import ValuePresence from 'appkit/mixins/presence'`
`import Validator from 'appkit/mixins/valid'`

ValidInputTextField = Ember.TextField.extend(ValuePresence, Validator);

`export default ValidInputTextField`