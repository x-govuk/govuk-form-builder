# Convert a hash containing supplied and expected contents
# into either supplied or expected
#
# args = { placeholder: { provided: 'Seymour Skinner', output: 'Seymour Skinner' } }
# extract_args(args, :output)
#
# => { placeholder: 'Seymour Skinner' }
#
def extract_args(args, subkey)
  args.each.with_object({}) { |(k, v), h| h[k] = v[subkey] }
end

def underscores_to_dashes(val)
  val.to_s.tr('_', '-')
end

def dashes_to_underscores(val)
  val.to_s.tr('-', '_')
end

def rails_version
  ENV.fetch('RAILS_VERSION') { '6.1.1' }
end

def rails_version_later_than_6_1_0?
  rails_version >= '6.1.0'
end
