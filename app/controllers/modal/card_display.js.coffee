CardDetailsController = Ember.Controller.extend({
  needs: ['modal'],
  title: 'Card Details',

  assigneesWatcher: ( ->
    Ember.run.once =>
      assignee = @get('assignees.firstObject')
      @send('reassign', assignee) if assignee?
  ).observes('assignees.@each')

  assigneeWatcher: ( ->
    assignees = @get('assignees')
    Ember.RSVP.Promise.resolve(@get('model.assignee')).then (assignee) ->
      if not Ember.isBlank(assignees)
        assignees.removeAt(0)
      return unless assignee?
      if Ember.isBlank(assignees)
        assignees.addObject(assignee)
      else
        assignees.replace(0, 1, [assignee])
  ).observes('model')

  actions: {

    save: ->
      model = @get('model')
      store = @get('store')
      model.get('activityStream').then((stream) ->
        items = for key of model.changedAttributes()
          store.createRecord('activity-item', {date: new Date(), activity: key, card: model}).save()
        Em.RSVP.all(items).then (activities) -> stream.pushObjects(activities)
      ).then => @send('closeModal')

    reassign: (user) ->
      model = @get('model')
      store = @get('store')
      Ember.RSVP.Promise.resolve(model.get('assignee')).then (assignee) ->
        return if Ember.guidFor(assignee) is Ember.guidFor(user)
        model.set('assignee', user)
        record = store.createRecord('activity-item', {date: new Date(), activity: "Re-assigned to #{user.get('email')}", card: model})
        Em.RSVP.all([model.get('activityStream'), record.save()]).then((promises) ->
          [stream, activity]=promises
          stream.addObject(activity)
        )

    archive: ->
      model = @get('model')
      store = @get('store')
      model.set('archived', true)
      record = store.createRecord('activity-item', {date: new Date(), activity: 'Card was archived!', card: model})
      Em.RSVP.all([model.get('activityStream'), record.save()]).then((promises) ->
        [stream, activity]=promises
        stream.addObject(activity)
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
