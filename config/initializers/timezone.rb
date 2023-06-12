# Timezone::Lookup.config(:geonames) do |c|
#   c.username = 'tofuzzy70'
# end

Timezone::Lookup.config(:google) do |c|
  c.api_key = ENV['GOOGLE_KEY']
end