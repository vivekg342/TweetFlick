Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, '8AL72cho2nqFZ4PQERT8rQ', 'rM4PUPAbTNe9exOotqaTebI0oxP1WXknWX4m42dow'
  #provider :facebook, 'KEY', 'SECRET'
end
  
