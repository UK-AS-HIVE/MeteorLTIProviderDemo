
Router.route 'launchUrl',
  path: '/'
  where: 'server'
  action: ->
    console.log @request.body
    # Log user in, with new Account if necessary
    account = Meteor.users.findOne({'services.lti.user_id': @request.body.user_id})?._id
    if not account
      account = Accounts.createUser
        username: @request.body.tool_consumer_instance_name #@request.body.user_id
        #email: @request.body.tool_consumer_instance_contact_email

    token = Accounts._generateStampedLoginToken()
    hashedToken = Accounts._hashStampedToken token
    console.log 'generated token', token

    Meteor.users.update account,
      $set:
        'services.resume.loginTokens': [hashedToken]
        'services.lti': @request.body

    console.log 'signing in account via LTI...', account

    @response.statusCode = 303
    @response.setHeader 'Location', '/tool'
    @response.setHeader 'Set-Cookie', "meteor_login_token=#{token.token}; Max-Age=3600; Version=1"
    @response.setHeader 'Set-Cookie', "meteor_login_token_expires=#{token.when}; Max-Age=3600; Version=1"
    @response.end "Redirecting to LTI tool..."

Router.route 'home',
  path: '/tool'
  onBeforeAction: ->
    console.log 'Meteor user?', Meteor.user()
    if not Meteor.user()
      token = Cookie.get 'meteor_login_token'
      Meteor.loginWithToken token, (err, result) ->
        console.log 'finished calling loginWithToken', err, result
    @next()

