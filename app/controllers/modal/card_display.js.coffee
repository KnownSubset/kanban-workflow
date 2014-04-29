CardDetailsController = Ember.Controller.extend({
  needs: ['modal'],
  title: 'Card Details',

  actions: {

    save: ->
      model = @get('model')
      store = @get('store')
      model.get('activityStream').then((stream) ->
        items = for key of model.changedAttributes()
          store.createRecord('activityitem', {date: new Date(), activity: key, card: model}).save()
        Em.RSVP.all(items).then (activities) ->
          stream.pushObjects(activities)
          activities.forEach (activity) ->
            activity.set('card', model)
            activity.save()
      ).then => @send('closeModal')

    archive: ->
      model = @get('model')
      store = @get('store')
      model.set('archived', true)
      record = store.createRecord('activityitem', {date: new Date(), activity: 'Card was archived!', card: model})
      Em.RSVP.all([model.get('activityStream'), record.save()]).then((promises) ->
        [stream, activity]=promises
        stream.pushObject(activity)
        activity.set('card', model)
        activity.save()
      ).then => @send('closeModal')

    remove: ->
      #r = confirm('Are you sure you want to delete this card?')
      #if r
      model = @get('model')
      model.get('column').then (column) ->
        column.get('cards').then (cards)->
          cards.removeObject(model)
      model.deleteRecord()
      this.send('closeModal')

      false

    cancel: ->
      this.get('model').rollback()
      this.send('closeModal')
  }
})

`export default CardDetailsController`
