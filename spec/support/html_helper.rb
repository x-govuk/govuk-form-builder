def extract_classes(nokogiri_document, selector)
  nokogiri_document
    .at_css(selector)
    .attributes['class']
    .value
    .split(' ')
end
