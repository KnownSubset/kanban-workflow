BasicRoute = Ember.Route.extend({

  showModal: (route, name, model) ->
    this.controllerFor('modal').set('modalClass', null)
    controller = route.controllerFor('modal/'+name);
    this.render('modal/'+name, { into: 'modal/modal', outlet: 'modalBody' })
    #the template to render, {#the template to render into, #the name of the outlet in that template, #the controller to user for the template
    if (controller)
      if (model) then controller.set('model', model)
      if (controller && controller.onShow) then controller.onShow()
      controller.set('flashMessage', null)

});
`export default BasicRoute`
