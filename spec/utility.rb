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
