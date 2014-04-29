`import { test, moduleFor, moduleForComponent } from 'ember-qunit'`

moduleForComponent('hover-aware-text-field', "Component - Hover Aware Text Field",{
  needs: ['component:update-aware-text-field']
});

test("template renders", () ->
  component = this.subject();

  ok(component)
  ok(this.$('.editable_text_field'))
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

  equal(this.$('div').find('input').attr('placeholder'), text)
)

test("template displays textbox when editable", () ->
  model = 'text'
  component = this.subject();

  Em.run -> component.set('isEditable', true)
  Em.run -> component.set('model', model)

  equal(this.$().find('div.editable-field.outlined').length, 1)
  equal(this.$().find('div.editable-field.outlined').text().trim(), model)
)

test("textbox is focused when editing", () ->
  model = 'text'
  component = this.subject();

  Em.run -> component.set('isEditing', true)
  Em.run -> component.set('isEditable', true)
  Em.run -> component.set('model', model)

  equal(this.$().find('input').length, 1)
  equal(this.$().find('input').attr('value'), model)
  equal(this.$().find('input').is(':focus'), true)
)

test("component displays default message if model is empty", () ->
  component = this.subject();

  Em.run -> component.set('model', null)

  equal(this.$().find('div.editable-field').text().trim(), 'Click to edit')
)