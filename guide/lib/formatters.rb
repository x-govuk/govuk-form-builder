module Formatters
  def render_figure(template, **args, &block)
    render(template, **args, &block)
  end

  def format_slim(raw, **args)
    # FIXME investigate pretty slim
    # FIXME not sure why when we're several
    #       blocks deep we need to unescape more
    #       than once
    beautify(
      CGI.unescapeHTML(
        CGI.unescapeHTML(
          Slim::Template.new { raw }.render(OpenStruct.new(args))
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
