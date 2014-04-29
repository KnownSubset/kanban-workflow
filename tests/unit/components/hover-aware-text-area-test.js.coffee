`import { test , moduleForComponent } from 'ember-qunit'`

moduleForComponent('hover-aware-text-area', "Component - Hover Aware Text Area",{
  needs: ['component:update-aware-text-area']
});

test("template renders", () ->
  component = this.subject();

  ok(component)
  ok(this.$('.editable_text_area'))
)

test("template displays the basic values given", () ->
  model = 'text'
  component = this.subject();

  Em.run -> component.set('model', model)

  equal(this.$('div:contains("text")').text().trim(), model)
)
test("template displays the placeholder text", () ->
  component = this.subject();
  text = "placeholder text to display"

  Em.run -> component.set('isEditing', true)
  Em.run -> component.set('isEditable', true)
  Em.run -> component.set('placeholderText', text)
  this.$()

  equal(this.$('div').find('textarea').attr('placeholder'), text)
)

test("template displays textbox when editable", () ->
  model = 'text'
  component = this.subject();

  Em.run -> component.set('isEditable', true)
  Em.run -> component.set('model', model)

  equal(this.$().find('div.editable-area.outlined').length, 1)
  equal(this.$().find('div.editable-area.outlined').text().trim(), model)
)

test("textbox is focused when editing", () ->
  model = 'text'
  component = this.subject();

  Em.run -> component.set('isEditing', true)
  Em.run -> component.set('isEditable', true)
  Em.run -> component.set('model', model)

  equal(this.$().find('textarea').length, 1)
  equal(this.$().find('textarea').val(), model)
  equal(this.$().find('textarea').is(':focus'), true)
)

test("component displays default message if model is empty", () ->
  component = this.subject();

  Em.run -> component.set('model', null)

  equal(this.$().find('div.editable-area').text().trim(), 'Click to edit')
)
