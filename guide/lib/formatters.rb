module Formatters
  def format_html(raw)
    HtmlBeautifier
      .beautify(
        raw
          .gsub(">", ">\n")
          .gsub("\<\/", "\n\<\/")
          .strip
    )
  end
end
