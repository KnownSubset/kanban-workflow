`import ApplicationController from 'appkit/controllers/application'`
`import AuthenticatedUser from 'appkit/authentications/authenticated-user'`
`import { test, moduleFor } from 'ember-qunit'`

[App,controller,testHelper] = []

moduleFor("controller:application", "Unit - Controller - Application", {
  setup: ->
    App = startApp()
    testHelper = Ember.Object.createWithMixins(FactoryGuyTestMixin).setup(App)
    store = testHelper.getStore()
    user = store.makeFixture('user')
    authenticatedUser = AuthenticatedUser.create({id: user.id, email: user.email, token: 'token', lastUpdated: 0})
    authenticatedUser.save()
    controller = @subject({model: authenticatedUser, transitionToRoute: () -> Ember.RSVP.Promise.resolve(null)})
  teardown: ->
    Ember.run(App, 'destroy')
    Ember.run(testHelper, 'teardown')
})

test('sending an alert to the application controller will add it into the collection of alerts', ()->
  alert = {type: 'warning', message: "the input contains invalid characters"}

  Em.run -> controller.send('alert', alert)

  ok(jQuery.inArray(alert, controller.get('alerts')) >= 0, "Alert should have been registered with the controller")
)

test('signing out the user will replace the model on the controller', ()->
  ic.ajax.defineFixture("#{ENV.organization_api}/logout", {
    response: {},
    jqXHR: {},
    textStatus: 'success'
  })
  Em.run -> controller.send('logout')

  ok(not controller.get('model'))
)

test('when an invalid formatted alert is sent, show a generic alert message ', ()->
  alert1 = {type: 'warning', mesge: "the input contains invalid characters"}
  alert2 = {ty: 'warning', message: "the input contains invalid characters"}
  alert3 = {}

  Em.run ->
    controller.send('alert', alert1)
    controller.send('alert', alert2)
    controller.send('alert', alert3)

  ok(jQuery.inArray(alert1, controller.get('alerts')) < 0, "Alert should have NOT been registered with the controller")
  ok(jQuery.inArray(alert2, controller.get('alerts')) < 0, "Alert should have NOT been registered with the controller")
  ok(jQuery.inArray(alert3, controller.get('alerts')) < 0, "Alert should have NOT been registered with the controller")
  ok(controller.get('alerts').anyBy('type', 'danger'), "Danger Alert should have been registered with the controller")
  ok(controller.get('alerts').anyBy('message', 'System Error'), "Generic Alert should have been registered with the controller")
)

test('when a null alert is sent, ignore the alert', ()->

  Em.run -> controller.send('alert', null)

  ok(jQuery.inArray(null, controller.get('alerts')) < 0, "Alert should have been NOT registered with the controller")
)

test('will add a default for dismiss to an alert if it is not present', ()->
  alert = {type: 'warning', message: "the input contains invalid characters"}

  Em.run -> controller.send('alert', alert)

  alert = controller.get('alerts.lastObject')
  ok(alert.dismiss, "Alert should a value for dismiss")
)

test('will not override a default for dismiss to an alert if it is present', ()->
  alert = {type: 'warning', message: "the input contains invalid characters", dismiss: false}

  Em.run -> controller.send('alert', alert)

  alert = controller.get('alerts.lastObject')
  ok(not alert.dismiss, "Alert should have false for dismiss")
)

test('will add a default for fade to an alert if it is not present', ()->
  alert = {type: 'warning', message: "the input contains invalid characters"}

  Em.run -> controller.send('alert', alert)

  alert = controller.get('alerts.lastObject')
  ok(alert.fade, "Alert should a value for fade")
)

test('will not override with default for fade to an alert if it is present', ()->
  alert = {type: 'warning', message: "the input contains invalid characters", fade: false}

  Em.run -> controller.send('alert', alert)

  alert = controller.get('alerts.lastObject')
  ok(not alert.fade, "Alert should have false for fade")
)