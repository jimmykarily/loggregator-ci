#!/usr/bin/env ruby

require 'json'

setting_names = %w{
  API_VERSION
  CLIENT_ID
  DIEGO_CELL_COUNT
  DOPPLER_COUNT
  END_RPS
  EVENT_COUNTER_COUNT
  LOG_API_COUNT
  LOG_EMITTER_COUNT
  LOG_EMITTER_INSTANCE_COUNT
  LOG_SIZE
  METRIC_EMITTER_COUNT
  ORG
  ROUTER_COUNT
  SPACE
  START_RPS
  STEPS
  SYSTEM_DOMAIN
}

settings = ENV.select { |k, _| setting_names.include?(k) }
settings.each do |k, v|
  if v.to_i != 0
    settings[k] = v.to_i
  end
end

# Ensure all environment settings are given. This will raise an error if the
# key is not found.
setting_names.each { |name| settings.fetch(name) }

puts 'Writing "deployment-settings/settings.json"'
File.open('deployment-settings/settings.json', 'w') do |f|
  f.write(JSON.pretty_generate(settings))
end

puts 'Done.'
