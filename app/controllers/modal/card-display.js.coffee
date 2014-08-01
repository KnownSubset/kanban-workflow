`import AuthenticatedUser from 'appkit/authentications/authenticated-user'`

CardDetailsController = Ember.Controller.extend({
  needs: ['modal'],
  title: 'Card Details',
  comments: '',

  disableSubmit: Ember.computed('comments', 'model.name', 'model.description', ->
    model = @get('model')
    items = (key for key of model.changedAttributes())
    comments = @get('comments')
    Em.isBlank(items) and Em.isBlank(comments)
  )

  assigneesWatcher: ( ->
    Ember.run.once =>
      assignee = @get('assignees.firstObject')
      @send('reassign', assignee) if assignee?
  ).observes('assignees.@each')

  assigneeWatcher: ( ->
    assignees = @get('assignees')
    Ember.RSVP.Promise.resolve(@get('model.assignee')).then (assignee) ->
      unless Ember.isBlank(assignees)
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
      items = (key for key of model.changedAttributes())
      comments = @get('comments')
      return if @get('saveEnabled')
      store = @get('store')
      Ember.RSVP.all([store.find('profile', AuthenticatedUser.current().get('id')),model.get('activityStream')]).then( (promises) ->
        [profile, stream] = promises
        activities = []
        activities.push(store.createRecord('activity-item', {date: new Date(), actor: profile, activity: "Updated: #{items.join(', ')}", card: model}).save()) unless Em.isBlank(items)
        activities.push(store.createRecord('activity-item', {date: new Date(), actor: profile, activity: "Commented: #{comments}", card: model}).save()) unless Em.isBlank(comments)
        Ember.RSVP.all(activities).then (activityItems) ->
          stream.pushObjects(activityItems)
      ).then =>
        @set('comments', '')
        @send('closeModal')

    reassign: (profile) ->
      model = @get('model')
      store = @get('store')
      Ember.RSVP.Promise.resolve(model.get('assignee')).then (assignee) ->
        return if Ember.guidFor(assignee) is Ember.guidFor(profile)
        model.set('assignee', profile)
        currentUser = AuthenticatedUser.current()
        Em.RSVP.all([store.find('profile', currentUser.get('id')),profile.get('user')]).then (promises) ->
          [profile, user] = promises
          record = store.createRecord('activity-item', {date: new Date(), actor: profile, activity: "Re-assigned to #{user.get('email')}", card: model})
          Em.RSVP.all([model.get('activityStream'), record.save()]).then((promises) ->
            [stream, activity]=promises
            stream.addObject(activity)
          )

    archive: ->
      model = @get('model')
      store = @get('store')
      model.set('archived', true)
      currentUser = AuthenticatedUser.current()
      store.find('profile', currentUser.get('id')).then((profile) ->
        record = store.createRecord('activity-item', {date: new Date(), actor: profile, activity: 'Card was archived!', card: model})
        Em.RSVP.all([model.get('activityStream'), record.save()]).then (promises) ->
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
      this.set('comments', '')
      this.get('model').rollback()
      this.send('closeModal')
  }


})

`export default CardDetailsController`
