module Formatters
  def render_slim(raw, **args)
    beautify(Slim::Template.new { raw }.render(OpenStruct.new(args)))
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
