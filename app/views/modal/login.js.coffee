###
  A modal view for handling user logins

  @class LoginView
  @extends FullConnect.ModalBodyView
  @namespace FullConnect
  @module FullConnect
###
`import ModalBodyView from 'appkit/views/modal/modal_body'`

LoginView = ModalBodyView.extend({
  templateName: 'modal/login',

  didInsertElement: ->
    this._super()
    # Get username and password from the browser's password manager,
    # if it filled the hidden static login form:
    loginController = this.get('controller');
    loginController.set('email', $('#hidden-login-form input[name=username]').val());
    loginController.set('password', $('#hidden-login-form input[name=password]').val());

    Ember.run.schedule('afterRender', () ->
      $('form.login-form input.form-control').keydown((e) ->
        wasEnterPressed = e.keyCode is 13;
        if (wasEnterPressed) then loginController.send('login')
      )
    )

});

`export default LoginView`