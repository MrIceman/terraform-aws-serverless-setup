lambdas = {
  // name of your lambda
  "auth" = {
    // name of your go file
    handler     = "auth"
    lambda_name = "loremio-auth-lambda"
    // where your lambda zip is located
    lambda_path = "../../cmd/auth/auth"
    // your endpoints
    endpoints   = [
      {
        endpoint         = "GET /auth"
        is_authenticated = true
      },
      {
        endpoint         = "POST /auth"
        is_authenticated = false
      }
    ],
  },
  "vendor" = {
    handler     = "vendor_"
    lambda_name = "loremio-vendor-lambda"
    lambda_path = "../../cmd/vendor_/vendor_"
    endpoints   = [
      {
        endpoint         = "GET /vendor"
        is_authenticated = true
      },
      {
        endpoint         = "POST /vendor"
        is_authenticated = true
      },
      {
        endpoint         = "GET /vendor/{id}"
        is_authenticated = true
      },
      {
        endpoint         = "GET /vendor/search"
        is_authenticated = true
      },
    ]
  },
  "profile" = {
    handler     = "userprofile"
    lambda_name = "loremio-profile-lambda"
    lambda_path = "../../cmd/userprofile/userprofile"
    endpoints   = [
      {
        endpoint         = "GET /profile"
        is_authenticated = true
      },
      {
        endpoint         = "PUT /profile"
        is_authenticated = true
      },
    ]
  }
}