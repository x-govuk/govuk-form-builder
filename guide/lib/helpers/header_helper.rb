module Helpers
  module HeaderHelper
    def header(level: 2, id: nil, classes: nil)
      tag = "h#{level}"

      { tag:, id:, class: classes }.compact
    end
  end
end
