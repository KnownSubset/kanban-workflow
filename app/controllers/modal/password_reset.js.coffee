`import Alertable from 'appkit/mixins/alertable'`

PasswordResetController = Ember.Controller.extend(Alertable, {
  title: 'Forgot Password?',
  sendingReset: false,

  passwordResetButtonText: ( ->
    if this.get('sendingReset') then 'Sending Password Reset...' else 'Reset Password'
  ).property('sendingReset'),

  sendResetDisabled: ( ->
    @get('sendingReset') or Ember.isBlank(@get('email')) or $('.modal-body input.email').hasClass('invalid-text')
  ).property('email', 'sendingReset'),

  actions: {
    sendReset: () ->
      this.set('sendingReset', true)
      passwordResetController = this

      ic.ajax.request("#{ENV.RESTEndpoint}/password_resets", {
        data: { email: this.get('email') },
        type: 'POST'
      }).then( ->
        #// Successful reset
          passwordResetController.set('sendingReset', false)
          passwordResetController.send('alert', {type: "info", message: "An email has been sent to #{passwordResetController.get('email')} with further instructions for resetting your password"})
      ).catch( (response) ->
        #// Failed to reset
          passwordResetController.send('alert', {type: "warning", message: $.parseJSON(response.jqXHR.responseText).message, dismiss:true})
          passwordResetController.set('sendingReset', false)
      )
      false
  }
});

`export default PasswordResetController`
