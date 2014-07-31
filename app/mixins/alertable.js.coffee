Alertable = Ember.Mixin.create({
  alerts: null
  actions:
    alert: (alert)->
      if not @get('alerts')? then @set('alerts', [])
      if not (alert? && alert.type? && alert.message?)
        alert = {type: 'danger', message: 'System Error'}
      if not alert.dismiss?
        alert.dismiss = true
      if not alert.fade?
        alert.fade = true
      @get('alerts').pushObject(alert)
      false
    closeAlert: (alert) ->
      new_alerts = @get('alerts').reject( (item) -> item is alert)
      @set('alerts', new_alerts)
});

`export default Alertable`