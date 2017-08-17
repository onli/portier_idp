require 'sinatra'
require 'base64'
require 'inifile'

rsa_public = nil
# TODO: It would be better not to have the key as global variables, but to load them only when needed
rsa_private = nil
ownUrl = nil

configure do
    # Create the jwks, if not existing already
    if (File.exists?('rsa.pem'))
        rsa_private = OpenSSL::PKey::RSA.new File.read 'rsa.pem'
    else
        rsa_private = OpenSSL::PKey::RSA.generate 4096
    end
    rsa_public = rsa_private.public_key

    # Read the absolute URL from the config.ini
    config = IniFile.load('config.ini')
    ownUrl = config['main']['url']
end

# the webfinger endpoint confirms to portier that a user is registered,
# and that this service supports portier as auth method
get '/.well-known/webfinger' do
    if (params[:rel] == 'https://portier.io/specs/auth/1.0/idp')
        email = params[:resource].gsub('acct:', '')

        return JSON.generate({
            "subject": "acct:" + email,
            "links":
                [
                {
                "rel": "https://portier.io/specs/auth/1.0/idp",
                "href": ownUrl
                }
                ]
            }).to_s
    end
end

# Portier then gets this endpoint, which has two relevant information:
# The jwks_uri endpoint (/.well_known/jwks) and the auth base (/login), both
# given as absolute urls
get '/.well-known/openid-configuration' do

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
get '/.well-known/jwks' do
    header 'Content-Type: application/json'
    JSON.generate({
        "kty": "RSA",
        "alg": "RS256",
        "use": "sig",
        "n": Base64.urlsafe_encode64(rsa_public.params['n'].to_s),
        "e": Base64.urlsafe_encode64(rsa_public.params['e'].to_s),
    }).to_s
end