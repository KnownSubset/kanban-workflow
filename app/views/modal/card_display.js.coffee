`import ModalBodyView from 'appkit/views/modal/modal_body'`

CardDisplayView = ModalBodyView.extend({
  templateName: 'modal/card_display',

  focus: (->
    this.$().focus()
  ).on('didInsertElement')

});

`export default CardDisplayView`