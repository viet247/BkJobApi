Devise.setup do |config|
  config.jwt do |jwt|
    jwt.secret = ENV.fetch("DEVISE_JWT_SECRET_KEY") { "35c20fc1fa04fe79660ba61ff15cf95cb6835e29eaf358a6e0539bfa6cbe3c63b9212e561b276f70b8d480a670817550e08156dd1b948a2d66bdc05a7479cb60" }
    jwt.dispatch_requests = [
      [ "POST", %r{^/login$} ]
    ]
    jwt.revocation_requests = [
      [ "DELETE", %r{^/logout$} ]
    ]
    jwt.expiration_time = 30.minutes.to_i
  end
end
