`import ModalBodyView from 'appkit/views/modal/modal-body'`

HideModalView = ModalBodyView.extend({
  # No rendering!
  render: ((buffer) -> ),
  didInsertElement: ->
    $('#modal').modal('hide');
});

`export default HideModalView`