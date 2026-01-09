accounts = [
  {
    name = "my-test"
    id   = "354247558183"
  }
]

users = [
  {
    email     = "contact.joe.burton@gmail.com"
    firstName = "Test"
    lastName  = "User"
    assignments = [{
      account = "my-test"
      role    = "read-only"
    }]
  }
]
