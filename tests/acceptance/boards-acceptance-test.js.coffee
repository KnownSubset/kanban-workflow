`import AuthenticatedUser from 'appkit/authentications/authenticated-user'`

[App, testHelper, boards, store] = []

module('Acceptances - Boards', {
  setup: ->
    App = startApp()
    testHelper = Ember.Object.createWithMixins(FactoryGuyTestMixin).setup(App)
    store = testHelper.getStore()
    random = Math.floor(Math.random() * 6) + 1
    profile = store.makeFixture('profile')
    boards = store.makeList('board', random, {members: [profile.id]})
    store.makeList('board', random)
    profile.boards = boards.mapBy('id')
    AuthenticatedUser.create({id: profile.id, email: 'fake@user.com', token: 'token', lastUpdated: 0}).save()
  teardown: ->
    Ember.run(App, 'destroy')
    Ember.run(testHelper, 'teardown')
})

test('Each board is displayed', ->
  visit("/boards")

  andThen ->
    boards.forEach (board) ->
      ok(find("div.board:contains('#{board.name}')"), "board for #{board.name} should exist")
)

test('click a board, visits that board', ->
  board = boards[0]

  visit("/boards")
  andThen ->
    click("div.board:contains('#{board.name}')")

  andThen ->
    ok(find("div.board:contains('#{board.name}')"), "board for #{board.name} should exist")
    equal(find("div.board").length, 1, "only a single board should be displayed")
    equal(currentPath(), 'board', "path should be for board that was selected: #{board.name}")
    equal(currentURL(), "/boards/#{board.id}", "path should be for board that was selected: #{board.name}")
)

test('user can create a board, and then visit that board', ->
  board = null
  profile = store.makeFixture('profile')
  AuthenticatedUser.create({id: profile.id, email: 'fake@user.com', token: 'token', lastUpdated: 0}).save()
  Em.run ->
    store.find('profile', profile.id).then (user) ->
      profile = user
  wait()

  visit("/boards")
  click("button:contains('Board')")
  andThen ->
    profile.get('boards').then (boards) ->
      board = boards.get('firstObject')
  wait()
  andThen ->
    click("div.board:contains('#{board.get('name')}')")

  andThen ->
    ok(find("div.board:contains('#{board.get('name')}')"), "board for #{board.get('name')} should exist")
    equal(find("div.board").length, 1, "only a single board should be displayed")
    equal(currentPath(), 'board', "path should be for board that was selected: #{board.get('name')}")
    equal(currentURL(), "/boards/#{board.get('id')}", "path should be for board that was selected: #{board.get('name')}")
)
