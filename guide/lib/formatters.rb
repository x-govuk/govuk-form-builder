module Formatters
  def render_slim(raw, **args)

    beautify(
      CGI.unescapeHTML(
        CGI.unescapeHTML(
          Slim::Template.new { raw }.render(OpenStruct.new(args)).to_s
        )
      )
    )
  end

private

  def beautify(html)
    HtmlBeautifier
      .beautify(
        html
          .gsub(">", ">\n")
          .gsub("\<\/", "\n\<\/")
          .strip
    )
  end
end
