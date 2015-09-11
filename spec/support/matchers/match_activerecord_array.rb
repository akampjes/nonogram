RSpec::Matchers.define :match_clue_array do |expected|
  match do |actual|
    actual, expected = [actual, expected].map { |a| a.map { |e| [e.lengths, e.orientation, e.position ] } }
    expect(actual).to match_array expected
  end

  failure_message do |record|
    "expected #{actual} to equal #{expected}"
  end
end
