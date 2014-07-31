ModalView = Ember.View.extend({
  elementId: 'modal',
  templateName: 'modal/modal',
  classNameBindings: [':modal-dialog', 'controller.modalClass']
});

`export default ModalView`
