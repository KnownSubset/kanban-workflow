###
  A base class for helping us display modal content

  @class ModalView
  @extends FullConnect.View
  @namespace FullConnect
  @module FullConnect
###
`import BasicView from 'appkit/views/basic'`

ModalView = BasicView.extend({
  elementId: 'fullConnect-modal',
  templateName: 'modal/modal',
  classNameBindings: [':modal-dialog', 'controller.modalClass']
});

`export default ModalView`
