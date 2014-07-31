`import { test, moduleFor } from 'ember-qunit'`

controller = null
App = null

moduleFor("controller:modal/password-reset", "{{controller:modal/password-reset}}", {
  needs: ['controller:modal']

  setup: ->
    App = startApp()
    controller = @subject()

  teardown: ->
    Em.run -> App.destroy()

})

test("submiting to sendReset will make a JSON request to the back end", () ->
  ic.ajax.defineFixture("#{ENV.RESTEndpoint}/password_resets", {response: {}, jqXHR: {}, textStatus: 'success' })
  controller.set('email', "user@example.com" )

  controller.send('sendReset')

  wait().then ->
    equal(controller.get('alerts').get('length'), 1, "the controller should have been sent an alert")
    equal(controller.get('alerts')[0].message, "An email has been sent to #{controller.get('email')} with further instructions for resetting your password")

)

test("submitting to sendReset will display an error message if the request fails", () ->
  ic.ajax.defineFixture("#{ENV.RESTEndpoint}/password_resets", {response: {}, jqXHR: {responseText: "{\"message\": \"An error has occurred while resetting your password.\"}"}, textStatus: 'failure' })
  controller.set('email', "")

  controller.send('sendReset')

  wait().then ->
    equal(controller.get('alerts').get('length'), 1, "the controller should have been sent an alert")
    equal(controller.get('alerts')[0].message, "An error has occurred while resetting your password.")
)

