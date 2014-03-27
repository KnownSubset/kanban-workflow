#`import { test, moduleForModel } from 'appkit/tests/helpers/module_for'`
`import BasicView from 'appkit/views/basic'`
`import BoardView from 'appkit/views/board'`

controller = null
view = null
dispatcher = null
App = null

module("{{view 'board'}}", {
  setup: ->
    App = startApp();
    dispatcher = Ember.EventDispatcher.create()
    dispatcher.setup()
    Controller = Ember.Controller.extend({})
    controller = Controller.create({
      container: App.__container__,
      sendArray: [],
      send: (action) ->
        sendArray = @get('sendArray')
        sendArray.push(action)
    })
    view = Ember.View.create({
      controller: controller,
      container: App.__container__,
      template: Ember.Handlebars.compile('{{view "board"}}')
    })
    Ember.run(() ->  view.appendTo('#ember-testing'))

  teardown: ->
    Ember.run ->
      Ember.run(App, 'destroy')
      view.destroy()
      controller.destroy()
      dispatcher.destroy()
})

test("should be a extension of Ember's BasicView", () ->

  columnView = BoardView.create({})

  ok(columnView)
  ok(columnView instanceof BasicView)
  ok(columnView instanceof BoardView)
)

test("Creating a board should insert a div", () ->

  ok(view)
  ok(exists('.board'))
  ok(exists('div.board'), "A single div was inserted")
);

test("template displays nothing if model is empty", ->
  equal(view.$().text().trim(), '')
);

test("the name should be within the column", () ->
  model = Em.Object.create({name: "My name"})
  Ember.run -> controller.set('model', model)
  wait()

  ok(exists("div.board:Contains('#{model.name}')"), "the name should be within the column");
)

test("There should be a div for each column in the board", () ->
  model = Em.Object.create({name: "My name",  columns: [Ember.Object.create({}),Ember.Object.create({}),Ember.Object.create({})]})
  Ember.run -> controller.set('model', model)
  wait()

  cards = find('.column')
  equal(cards.length, 3)
)

test("There should be a div for each column in the board", () ->
  board =   {
    id:1,
    name: 'Board #1',
    description: 'Proin diam eros, egestas quis laoreet ac, rutrum vitae risus. Integer et justo eu libero euismod lacinia ut a urna. Phasellus commodo ipsum consequat turpis convallis luctus ullamcorper sit amet metus.',
    createdAt: Date(),
    #columns: [1,2,3]
  }

  columns = [
    {id:1, name: 'column #1_1', kind: 'manual', createdAt: Date(), cards: [1,2,3], board: board },
    {id:2, name: 'column #1_2', kind: 'automated', createdAt: Date(), cards: [], board: board },
    {id:3, name: 'column #1_3', kind: 'manual', createdAt: Date(), cards: [], board: board },
    {id:4, name: 'column #2_1', kind: 'automated', createdAt: Date(), cards: [4,5,6], board: board },
    {id:5, name: 'column #3_1', kind: 'manual', createdAt: Date(), cards: [7], board: board },
    {id:6, name: 'column #3_2', kind: 'manual', createdAt: Date(), cards: [8], board: board },
    {id:7, name: 'column #3_3', kind: 'manual', createdAt: Date(), cards: [9], board: board }
  ]

  board.columns = columns

  cards = [
    {
      id:1,
      name: 'card #1',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eget blandit orci. Integer consectetur mattis felis, ullamcorper mollis ligula hendrerit vitae. Sed rutrum odio et massa iaculis viverra. Curabitur enim urna, venenatis non volutpat ut, iaculis quis elit. Morbi at nulla blandit, eleifend ipsum eu, bibendum felis. Nulla eget lacus mauris. Etiam ullamcorper lectus vitae libero ultrices adipiscing. Praesent a lorem a sem accumsan ullamcorper. Aliquam ultrices non neque sed elementum. Maecenas egestas gravida ornare. Nunc mollis tortor eu urna gravida consequat.',
      column: columns[0]
    },{
      id:2,
      name: 'card #2',
      description: '',
      column: columns[0]
    },{
      id:3,
      name: 'card #3',
      description: 'short description',
      column: columns[0]
    },{
      id:4,
      name: 'card #4',
      description: 'Aenean cursus, metus et fermentum cursus, lectus enim condimentum diam, sed facilisis lorem metus sit amet neque. Nulla pretium purus eu luctus ullamcorper. Cras egestas elementum arcu, quis dignissim mauris bibendum vel. Etiam bibendum dui eros, vel tempor dolor aliquam at. Vestibulum malesuada velit sed ligula bibendum, eu commodo ante elementum. Phasellus consectetur lorem eget dui bibendum lobortis. Vestibulum id augue et diam cursus interdum. Integer tristique quis lectus sit amet elementum. Sed et pharetra lectus. Maecenas ut molestie sem. Sed nisl tortor, porta nec tristique quis, viverra ut nisi. Sed felis nisl, tempor non consectetur ac, laoreet in nibh. Etiam a rhoncus nisi. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis at purus eget urna imperdiet blandit ut sed elit.',
      column: columns[3]
    },{
      id:5,
      name: 'card #5',
      description: 'short description',
      column: columns[3]
    },{
      id:6,
      name: 'card #6',
      description: '',
      column: columns[3]
    },{
      id:7,
      name: 'card #7',
      description: 'short description',
      column: columns[4]
    },{
      id:8,
      name: 'card #8',
      description: '',
      column: columns[5]
    },{
      id:9,
      name: 'card #9',
      description: 'short description',
      column: columns[6]
    }
  ]
  columns[0].cards = [cards[0],cards[1],cards[2]]
  columns[3].cards = [cards[3],cards[4],cards[5]]
  columns[4].cards = [cards[6]]
  columns[5].cards = [cards[7]]
  columns[6].cards = [cards[8]]

  Ember.run -> controller.set('model', board)
  wait()

  equal(find('.column').length, board.columns.length)
)

test("Creating a card should insert a div", () ->
  click("button:contains('Create Card')")

  andThen ->
    equal(controller.get('sendArray.firstObject'), 'addCard', "The controller should have been sent the addCard action")
);