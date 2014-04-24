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

  showCardModal: (route, name, model, card) ->
    this.controllerFor('modal').set('modalClass', null)
    controller = route.controllerFor('modal/'+name);
    controller.set('card', card)
    this.render('modal/'+name, { into: 'modal/modal', outlet: 'modalBody' })
    #the template to render, {#the template to render into, #the name of the outlet in that template, #the controller to user for the template
    if (controller)
      if (model) then controller.set('model', model)
      if (controller && controller.onShow) then controller.onShow()
      controller.set('flashMessage', null)

  actions:
    showCardModal: (name, model, card)->
      @showCardModal(@, name, model, card)

});
`export default BasicRoute`
