`import BasicView from 'appkit/views/basic'`

CardView = BasicView.extend({
  templateName: 'card',
  classNames: ['card'],

  click: ->
      #This will delete for any click...ideally this would check to see if click occured on a button
      @get('controller').send('remove')
});

`export default CardView`
