require 'sinatra'

configure do
    # Create the jwks, if not existing already

    # Read the absolute URL from the config.ini
end

# the webfinger endpoint confirms to portier that a user is registered,
# and that this service supports portier as auth method
get '/.well_known/webfinger' do

end

# Portier then gets this endpoint, which has two relevant information:
# The jwks endpoint (/.well_known/jwk) and the login page (/login), both
# given as absolute urls
get '/.well_known/openid_configuration' do

end

# Show a login form where users can authenticate to the IdP with their
# password. A real IdP would support things like LDAP, but we keep it simple
get '/login' do

end

# Confirm the entered login for this IdP and user, then create the jwt and
# redirect the user back to portier with it
post '/login' do

end

# Echo the jwks, the keyset used to sign the web tokens. Portier fetches this
# at the end to confirm the jwt supposed to confirm the login
get '/.well_known/jwks' do

end