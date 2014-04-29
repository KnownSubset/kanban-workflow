`import Column from 'appkit/models/column'`
`import Card from 'appkit/models/card'`
`import Board from 'appkit/models/board'`

ApplicationAdapter = DS.FixtureAdapter.extend();

Board.FIXTURES = [{
  id: 1,
  name: 'Board #1',
  description: 'Proin diam eros, egestas quis laoreet ac, rutrum vitae risus. Integer et justo eu libero euismod lacinia ut a urna. Phasellus commodo ipsum consequat turpis convallis luctus ullamcorper sit amet metus.',
  createdAt: Date(),
  columns: [1, 2, 3]
},{
  id: 2,
  name: 'Board #2',
  description: 'Quisque vitae magna urna. In hac habitasse platea dictumst. Etiam feugiat arcu arcu, ac fermentum tortor iaculis nec. Nullam mattis semper risus. Pellentesque consectetur feugiat erat, eu auctor erat bibendum blandit. Nam et eros tempus sem imperdiet ultrices a eget urna. Duis elementum nisi dui. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Aliquam vitae massa et risus vestibulum imperdiet. Suspendisse potenti. Curabitur pretium, turpis vitae feugiat molestie, nulla nunc consequat nibh, nec fringilla ipsum nisl vel est. Sed aliquam eros vel erat eleifend, eget pharetra est dictum. Aliquam erat volutpat. Phasellus arcu enim, fermentum a sapien non, porttitor aliquet mauris. Ut sit amet diam fringilla, placerat tortor eu, mattis risus.',
  createdAt: Date(),
  columns: [4]
},{
  id: 3,
  name: 'Board #3',
  description: 'Curabitur tempus pulvinar ligula in consequat.',
  createdAt: Date(),
  columns: [5, 6, 7]
}]

Column.FIXTURES = [{id: 1, name: 'column #1_1', kind: 'manual', createdAt: Date(), cards: [1, 2, 3, 10], board: 1 },
{id: 2, name: 'column #1_2', kind: 'automated', createdAt: Date(), cards: [], board: 1 },
{id: 3, name: 'column #1_3', kind: 'manual', createdAt: Date(), cards: [], board: 1 },
{id: 4, name: 'column #2_1', kind: 'automated', createdAt: Date(), cards: [4, 5, 6], board: 2 },
{id: 5, name: 'column #3_1', kind: 'manual', createdAt: Date(), cards: [7], board: 3 },
{id: 6, name: 'column #3_2', kind: 'manual', createdAt: Date(), cards: [8], board: 3 },
{id: 7, name: 'column #3_3', kind: 'manual', createdAt: Date(), cards: [9], board: 3 }
]

Card.FIXTURES = [{
  id: 1,
  name: 'card #1',
  description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eget blandit orci. Integer consectetur mattis felis, ullamcorper mollis ligula hendrerit vitae. Sed rutrum odio et massa iaculis viverra. Curabitur enim urna, venenatis non volutpat ut, iaculis quis elit. Morbi at nulla blandit, eleifend ipsum eu, bibendum felis. Nulla eget lacus mauris. Etiam ullamcorper lectus vitae libero ultrices adipiscing. Praesent a lorem a sem accumsan ullamcorper. Aliquam ultrices non neque sed elementum. Maecenas egestas gravida ornare. Nunc mollis tortor eu urna gravida consequat.',
  column: 1
},
{
  id: 2,
  name: 'card #2',
  description: '',
  column: 1
},
{
  id: 3,
  name: 'card #3',
  description: 'short description',
  column: 1
},
{
  id: 4,
  name: 'card #4',
  description: 'Aenean cursus, metus et fermentum cursus, lectus enim condimentum diam, sed facilisis lorem metus sit amet neque. Nulla pretium purus eu luctus ullamcorper. Cras egestas elementum arcu, quis dignissim mauris bibendum vel. Etiam bibendum dui eros, vel tempor dolor aliquam at. Vestibulum malesuada velit sed ligula bibendum, eu commodo ante elementum. Phasellus consectetur lorem eget dui bibendum lobortis. Vestibulum id augue et diam cursus interdum. Integer tristique quis lectus sit amet elementum. Sed et pharetra lectus. Maecenas ut molestie sem. Sed nisl tortor, porta nec tristique quis, viverra ut nisi. Sed felis nisl, tempor non consectetur ac, laoreet in nibh. Etiam a rhoncus nisi. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis at purus eget urna imperdiet blandit ut sed elit.',
  column: 4
},
{
  id: 5,
  name: 'card #5',
  description: 'short description',
  column: 4
},
{
  id: 6,
  name: 'card #6',
  description: '',
  column: 4
},
{
  id: 7,
  name: 'card #7',
  description: 'short description',
  column: 5
},
{
  id: 8,
  name: 'card #8',
  description: '',
  column: 6
},
{
  id: 9,
  name: 'card #9',
  description: 'short description',
  column: 7
},
{
  id: 10,
  name: 'card #10',
  description: 'short description',
  column: 1,
  archived: true
}
]

`export default ApplicationAdapter`
