BasicController = Ember.Controller.extend({
  alerts: [],
  actions:
    alert: (alert)->
      if not (alert? && alert.type? && alert.message?)
        alert = {type: 'danger', message: 'System Error'}
      if not alert.dismiss?
        alert.dismiss = true
      if not alert.fade?
        alert.fade = true
      this.get('alerts').pushObject(alert)
})

`export default BasicController`
