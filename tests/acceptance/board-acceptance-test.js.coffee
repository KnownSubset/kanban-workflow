`import KeyCodes from 'appkit/helpers/keyCodes'`
`import AuthenticatedUser from 'appkit/authentication/authenticated-user'`

[App, board, column, card, testHelper, users, store] = []

module('Acceptances - Board', {
  setup: ->
    App = startApp()
    testHelper = Ember.Object.createWithMixins(FactoryGuyTestMixin).setup(App)
    store = testHelper.getStore()
    card = store.makeFixture('card')
    column = store.makeFixture('column', {cards: [card.id]})
    users = store.makeList('profile', 3)
    AuthenticatedUser.create({id: users[0].id, email: users[0].email, token: 'token', lastUpdated: 0}).save()
    board = store.makeFixture('board', {columns: [column.id], members: [users[0].id,users[1].id,users[2].id]})
    wait()
  teardown: ->
    Ember.run(App, 'destroy')
    Ember.run(testHelper, 'teardown')
})

test('Board renders', ->
  visit("/boards/#{board.id}")

  andThen ->
    exists("div.board:contains('#{board.name}')")
    boardElement = find("div.board:contains('#{board.name}')")
    ok(boardElement, "board for #{board.name} should exist")
)

test('Board renders out all current columns', 1, ->
  andThen ->visit("/boards/#{board.id}")

  andThen ->
    columnElement = find("div.board div.column:contains('#{column.name}')")
    ok(columnElement, "column for #{column.name} should exist")
)

test('User can add a column to the board', 1, ->
  visit("/boards/#{board.id}")
  click("div.board button:contains('Create Column')")

  andThen ->
    columnElements = find('div.board div.column')

    equal(columnElements.length, 2, "there should be another column")

)

test("User can update the board's name", 1, ->
  newBoardName = "blah blah blah"
  visit("/boards/#{board.id}")
  andThen ->
    field = find('div.board div.editable_text_field')
    field.trigger('mouseenter')
    click("div.board div.editable_text_field")
    fillIn('div.board input.editable-field', newBoardName)
    keyEvent('input:last', null, 'keydown', KeyCodes.tab)

  andThen ->
    ok(find("div.board:contains('#{newBoardName}')".length))
)

test("User can archive a card", ->
  visit("/boards/#{board.id}")
  click("button:contains('#{card.name}')")
  click("button:contains('Archive')")

  andThen ->
    ok(not exists("div.card:contains('#{card.name}')"))
)

test("User can re-assign a card", ->
  visit("/boards/#{board.id}")
  click("button:contains('#{card.name}')")
  click("div.modal .dropdown-toggle")
  user = null
  Em.run ->
    store.find('user', users[1].id).then (profile) ->
      user = profile
    wait()

    andThen ->
      click("div.modal div.dropdown-menu div.select-element:contains('#{user.get('email')}')")
    andThen ->
      ok(exists("div.modal:contains('Re-assigned to #{user.get('email')}')"))
      click("button:contains('Save')")
)

test("User will be redirected if they are not a member of the board", ->
  user = store.makeFixture('user')
  AuthenticatedUser.create({id: user.id, email: user.email, token: 'token', lastUpdated: 0}).save()
  visit("/boards/#{board.id}")

  andThen ->
    equal(currentRouteName(), 'index');
    equal(currentPath(), 'index');
    equal(currentURL(), '/');
)

