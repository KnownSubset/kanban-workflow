ModalView = Ember.View.extend({
  elementId: 'fullConnect-modal',
  templateName: 'modal/modal',
  classNameBindings: [':modal-dialog', 'controller.modalClass']
});

`export default ModalView`
