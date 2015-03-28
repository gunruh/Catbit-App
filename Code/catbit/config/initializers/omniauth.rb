Rails.application.config.middleware.use OmniAuth::Builder do
  provider :fitbit, '3fc8ca4d052045179285308aadb129c1', '1d57103e84b74a2e8d94726bf5147c0d'
end
