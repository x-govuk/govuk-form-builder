def justify(pad, arr)
  arr.to_s.ljust(pad, ' ')
end

describe GOVUKDesignSystemFormBuilder::Traits::Localisation do
  let(:base_name_regexp) { GOVUKDesignSystemFormBuilder::Traits::Localisation::BASE_NAME_REGEXP }

  describe "BASE_NAME_REGEXP" do
    examples = {
      "attribute[a][b][c]"                              => %w(attribute a b c),
      "attribute[a_b][b_c][c_d]"                        => %w(attribute a_b b_c c_d),
      "attribute[a][0][b][c]"                           => %w(attribute a b c),
      "attribute[a][0][b][0][c]"                        => %w(attribute a b c),
      "attribute[a_b][0][c_d][0][d_e]"                  => %w(attribute a_b c_d d_e),
      "attribute[a][0][bbb0][c]"                        => %w(attribute a bbb0 c),

      "a_longer_attribute[a][b][c]"                     => %w(a_longer_attribute a b c),
      "a___longer___attribute[a][b][c]"                 => %w(a___longer___attribute a b c),

      "attribute[a][_][b]"                              => %w(attribute a b),
      "attribute[a][___][b]"                            => %w(attribute a b),
      "attribute[a][?][b]"                              => %w(attribute a b),

      "attribute with spaces[a][string with spaces][b]" => ["attribute with spaces", "a", "string with spaces", "b"],
    }

    longest_example_key = examples.keys.map(&:length).max

    examples.each do |input, expected|
      specify "#{justify(longest_example_key, input)} => #{expected}" do
        expect(input.scan(base_name_regexp)).to eql(expected)
      end
    end
  end
end
