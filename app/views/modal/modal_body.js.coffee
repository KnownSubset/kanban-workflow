ModalBodyView = Ember.View.extend({

  # Focus on first element
  didInsertElement: () ->
    $fullConnect_modal = $('#fullConnect-modal');
    $fullConnect_modal.modal('show');
    $fullConnect_modal.show();
    $('.modal').fadeIn();

    controller = this.get('controller');
    $fullConnect_modal.on('hide.fullConnect', (() -> controller.send('closeModal')) );

    $('#modal-alert').hide();

    modalBodyView = this;
    Ember.run.schedule('afterRender', (() -> modalBodyView.$('input:first').focus()) );

    title = this.get('title');
    if (title) then this._parentView.set('title', title)
  ,

  willDestroyElement: ->
    $('#fullConnect-modal').off('hide.fullConnect');
  ,

  # Pass the errors to our errors view
  displayErrors: (errors, callback) ->
    this.set('parentView.parentView.modalErrorsView.errors', errors);
    if (typeof callback is "function") then callback()
  ,

  flashMessageChanged: ( ->
    flashMessage = this.get('controller.flashMessage');
    if (flashMessage)
      messageClass = flashMessage.get('messageClass')? 'success'
      $alert = $('#modal-alert').hide().removeClass('alert-error', 'alert-success')
      $alert.addClass("alert alert-" + messageClass).html(flashMessage.get('message'))
      $alert.fadeIn()
  ).observes('controller.flashMessage')

});


`export default ModalBodyView`