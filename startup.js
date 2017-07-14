/* globals Meteor Accounts Versions Random DOCVERSION */
Meteor.startup(function () {
  Versions.remove({})
  Versions.insert({
    version: DOCVERSION
  })
  if (Meteor.users.find({}).count() > 0) {
    return
  }
  var password = process.env.LAIR_PASSWORD;
  Accounts.createUser({
    email: 'admin@localhost',
    password: password,
    isAdmin: true
  })
  console.log('Created admin@localhost with password ' + password)
})