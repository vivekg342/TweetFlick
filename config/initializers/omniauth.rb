Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, '9M92QotdJTXXaCfLeAvtQ', 'KRcBafgWyGK6kruVsfIRb0PuoZRhxyDAiaVSzDGT3M'
  #provider :facebook, 'KEY', 'SECRET'
end
  Twitter.configure do |config|
       config.consumer_key = '9M92QotdJTXXaCfLeAvtQ'
   config.consumer_secret = 'KRcBafgWyGK6kruVsfIRb0PuoZRhxyDAiaVSzDGT3M'
  end