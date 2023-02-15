module Helpers
  module HeaderHelper
    def header(level: 2, id: nil, classes: nil)
      tag = "h#{level}"

      { tag: tag, id: id, class: classes }.compact
    end
  end
end
