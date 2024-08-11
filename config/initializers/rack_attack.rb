# frozen_string_literal: true

# config/initializers/rack_attack.rb
module Rack
  class Attack
    # Permitir tráfego local
    safelist('allow-localhost') do |req|
      %w[127.0.0.1 ::1].include? req.ip
    end

    # Bloquear tráfego de um IP específico
    blocklist('block-bad-ips') do |req|
      bad_ips = %w[1.2.3.4 5.6.7.8]
      bad_ips.include?(req.ip)
    end

    # Limitar solicitações a 5 por segundo por IP
    throttle('req/ip', limit: 5, period: 1.second, &:ip)

    # Limitar tentativas de login a 5 por 20 minutos por IP
    throttle('logins/ip', limit: 5, period: 20.minutes) do |req|
      req.ip if req.path == '/users/sign_in' && req.post?
    end

    # Limitar tentativas de login a 5 por 20 minutos por conta de e-mail
    throttle('logins/email', limit: 5, period: 20.minutes) do |req|
      req.params.dig('user', 'email').presence if req.path == '/users/sign_in' && req.post?
    end

    # Bloquear solicitações de IPs suspeitos por 5 minutos após 5 solicitações falhas
    self.blocklisted_responder = lambda do |_env|
      [503, {}, ["Your IP has been blocked.\n"]]
    end

    # Log de bloqueios para ajudar na monitoração
    ActiveSupport::Notifications.subscribe('rack.attack') do |_name, _start, _finish, _request_id, payload|
      req = payload[:request]
      Rails.logger.info "Rack::Attack: #{req.path} blocked for #{req.ip}"
    end
  end
end
