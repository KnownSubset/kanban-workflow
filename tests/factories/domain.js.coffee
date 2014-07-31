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
    name: (num) -> "column #{num}"
    description: (num) -> "description #{num}"
  },
  default: {
    name: FactoryGuy.generate('name'),
    description: FactoryGuy.generate('description'),
    createdAt: new Date()
  }
})

FactoryGuy.define('user',{
  sequences: {
    userName: (num) -> "User #{num}"
    email: (num) -> "user#{num}@email.com"
  },
  default: {
    email: FactoryGuy.generate('email'),
    imageUrl: 'http://x.annihil.us/u/prod/marvel/i/mg/3/a0/537ba3793915b/standard_xlarge.jpg',
  }
})
FactoryGuy.define('profile',{
  default: {
    user: {}
  }
})

FactoryGuy.define('plan', {
  default: {
    name: "free_plan",
    description: 'free plan',
    capacity: 1000,
    cost: 0
  },
  pro_plan: {
    name: "big_plan",
    description: 'big description',
    capacity: 10000,
    cost: 100
  }
  enterprise_plan: {
    name: "enterprise_plan",
    description: 'enterprise_plan description',
    capacity: 100000,
    cost: 100
  }
})

FactoryGuy.define("organization",  {
  sequences: {
    name: (num) -> "organization #{num}"
    description: (num) -> "organization #{num} description"
  }

  default: {
    name: FactoryGuy.generate('name')
    description: FactoryGuy.generate('description')
  }
})

FactoryGuy.define("userGroup", {
  sequences: {
    name: (num) -> "User Group #{num}"
    description: (num) -> "User Group #{num} description"
  }

  default: {
    name: FactoryGuy.generate('name')
    description: FactoryGuy.generate('description')
  }
  adminUserGroup: {
    name: 'Admin User Group'
  }
})

FactoryGuy.define("permission", {
  sequences: {
    name: (num) -> "permission #{num}"
    description: (num) -> "permission #{num} description"
  },
  default: {
    name: FactoryGuy.generate('name')
    description: FactoryGuy.generate('description')
  }
})

FactoryGuy.define("role", {
  sequences: {
    name: (num) -> "role #{num}"
    description: (num) -> "role #{num} description"
  },
  default: {
    name: FactoryGuy.generate('name')
    description: FactoryGuy.generate('description')
  }
})

FactoryGuy.define("directory", {
  sequences: {
    name: (num) -> "directory #{num}"
    description: (num) -> "directory #{num} description"
  },
  default: {
    name: FactoryGuy.generate('name')
    description: FactoryGuy.generate('description')
  }
})

FactoryGuy.define("invitation", {
  sequences: {
    email: (num) -> "invitation#{num}@email.com"
  },
  default: {
    email: FactoryGuy.generate('email')
  }
})

exports = {}

`export default exports`
