module Helpers
  module Formatters
    def block_has_content?(block)
      block.call
    end

    def format_slim(raw, **args)
      # FIXME: investigate pretty slim
      # FIXME: not sure why when we're several
      #        blocks deep we need to unescape more
      #        than once
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
      # All tags except textarea appear to line up correctly when
      # newlines are placed after tags and before closing tags,
      # except textarea which we need to account for manually 😒
      HtmlBeautifier
        .beautify(
          html
            .gsub(">", ">\n")
            .gsub("\<\/", "\n\<\/")
            .gsub(/\>\s+\<\/textarea\>/, "></textarea>")
            .strip
        )
    end
  end
end
