FactoryGuy.define('activityItem', {
  sequences: {
    activity: (num) -> "activity #{num}"
  },
  default: {
    activity: FactoryGuy.generate('activity')
    date: new Date(),
  }
})

FactoryGuy.define('card', {
  sequences: {
    name: (num) -> "card #{num}"
    description: (num) -> "description #{num}"
    comments: (num) -> "comments #{num}"
  },
  default: {
    name: FactoryGuy.generate('name'),
    description: FactoryGuy.generate('description'),
    createdAt: new Date(),
    comments: FactoryGuy.generate('comments')
  }
})

FactoryGuy.define('board', {
  sequences: {
    name: (num) -> "board #{num}"
    description: (num) -> "description #{num}"
  },
  default: {
    name: FactoryGuy.generate('name'),
    description: FactoryGuy.generate('description'),
    createdAt: new Date()
  }
})

FactoryGuy.define('column', {
  sequences: {
    name: (num) -> "board #{num}"
    description: (num) -> "description #{num}"
  },
  default: {
    name: FactoryGuy.generate('name'),
    description: FactoryGuy.generate('description'),
    createdAt: new Date()
  }
})

exports = {}

`export default exports`
