RSpec::Matchers.define :match_legend_array do |expected|
  match do |actual|
    actual, expected = [actual, expected].map { |a| a.map { |e| [e.clues, e.orientation, e.position ] } }
    expect(actual).to match_array expected
  end

  failure_message do |record|
    "expected #{actual} to equal #{expected}"
  end
end
