# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

 Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
     origins 'kwangs-rorturtola.c9users.io','https://kwangs-rorturtola.c9users.io','kofian7-cloned-kofian.c9users.io',
     '192.168.1.65', 'kwanga.ml','10.0.2.2:8081'
#
     resource '*',
       headers: :any,
       methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
 end
