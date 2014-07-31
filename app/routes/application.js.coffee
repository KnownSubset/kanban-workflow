`import AuthenticatedUser from 'appkit/authentications/authenticated-user'`

ApplicationRoute = Ember.Route.extend({

  actions: {
    showModal: (name, model) ->
      @controllerFor('modal').set('modalClass', null)
      controller = @controllerFor('modal/'+name);
      this.render('modal/'+name, { into: 'modal/modal', outlet: 'modalBody' })
      #the template to render, {#the template to render into, #the name of the outlet in that template, #the controller to user for the template
      if (controller)
        if (model) then controller.set('model', model)
        if (controller && controller.onShow) then controller.onShow()

    showLogin: -> @send('showModal', 'login')

    closeModal: ->
      @render('modal/hide_modal', {into: 'modal/modal', outlet: 'modalBody'})
      @disconnectOutlet({outlet: 'modal', parentView: 'application'})

    showCardModal: (name, model) ->
      @showCardModal(@, name, model, card)
  }

  model: ->  AuthenticatedUser.current()

})
`export default ApplicationRoute`
