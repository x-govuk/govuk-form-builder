def extract_classes(nokogiri_fragment, selector)
  nokogiri_fragment
    .at_css(selector)
    .attributes['class']
    .value
    .split(' ')
end
