###
  An empty view for when we want to close a modal.

  @class HideModalView
  @extends FullConnect.ModalBodyView
  @namespace FullConnect
  @module FullConnect
###
`import ModalBodyView from 'appkit/views/modal/modal_body'`

HideModalView = ModalBodyView.extend({
  # No rendering!
  render: ((buffer) -> ),
  didInsertElement: ->
    $('#fullConnect-modal').modal('hide');
});

`export default HideModalView`