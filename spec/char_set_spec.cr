require "./spec_helper"
require "../src/chars/char_set"

Spectator.describe Chars::CharSet do
  let(byte_range) { 0x41..0x5a }
  let(char_range) { 'A'..'Z' }
  let(bytes)      { byte_range.to_a }
  let(chars)      { char_range.to_a }

  subject { described_class.new(chars) }

  describe "#initialize" do
    context "when given an Array of Int32s" do
      subject { described_class.new(bytes) }

      it "must populate #chars" do
        expect(subject.chars).to eq(chars)
      end

      it "must populate #bytes" do
        expect(subject.bytes).to eq(bytes)
      end
    end

    context "when given an Array of Chars" do
      subject { described_class.new(chars) }

      it "must populate #chars" do
        expect(subject.chars).to eq(chars)
      end

      it "must populate #bytes" do
        expect(subject.bytes).to eq(bytes)
      end
    end

    context "when given a Range(Int32, Int32)" do
      subject { described_class.new(byte_range) }

      it "must populate #chars" do
        expect(subject.chars).to eq(chars)
      end

      it "must populate #bytes" do
        expect(subject.bytes).to eq(bytes)
      end
    end

    context "when given a Range of Chars" do
      subject { described_class.new(char_range) }

      it "must populate #chars" do
        expect(subject.chars).to eq(chars)
      end

      it "must populate #bytes" do
        expect(subject.bytes).to eq(bytes)
      end
    end
  end

  describe "[]" do
    context "when given multiple byte arguments" do
      subject { described_class[0x41, 0x42, 0x43] }

      it "must populate #byte_set with the given bytes" do
        expect(subject.byte_set).to eq(Set{0x41, 0x42, 0x43})
      end

      it "must populate #char_set with the character values of the bytes" do
        expect(subject.char_set).to eq(Set{0x41.chr, 0x42.chr, 0x43.chr})
      end
    end

    context "when given multiple char arguments" do
      subject { described_class['A', 'B', 'C'] }

      it "must populate #char_set with the given chars" do
        expect(subject.char_set).to eq(Set{'A', 'B', 'C'})
      end

      it "must populate #byte_set with the byte values of the chars" do
        expect(subject.byte_set).to eq(Set{'A'.ord, 'B'.ord, 'C'.ord})
      end
    end

    context "when given byte and char arguments" do
      subject { described_class[0x41, 'B', 0x43] }

      it "must populate #byte_set with the given bytes" do
        expect(subject.byte_set).to eq(Set{0x41, 'B'.ord, 0x43})
      end

      it "must populate #char_set with the character values of the bytes" do
        expect(subject.char_set).to eq(Set{0x41.chr, 'B', 0x43.chr})
      end
    end

    context "when given a Range(Int32, Int32) argument" do
      subject { described_class[byte_range] }

      it "must expand the range" do
        expect(subject.bytes).to eq(byte_range.to_a)
      end
    end

    context "when given a Range(Char, Char) argument" do
      subject { described_class[char_range] }

      it "must expand the range" do
        expect(subject.chars).to eq(char_range.to_a)
      end
    end
  end

  describe "#<<(Char)" do
    let(char) { 'A' }
    let(byte) { char.ord.to_u8 }

    subject { described_class.new }

    before_each { subject << char }

    it "must add the Char to #char_set" do
      expect(subject.char_set.includes?(char)).to be(true)
    end

    it "must add the byte equivalent of the Char to #byte_set" do
      expect(subject.byte_set.includes?(byte)).to be(true)
    end
  end

  describe "#<<(Int32)" do
    let(char) { 'A' }
    let(byte) { char.ord.to_u8 }

    subject do
      described_class.new << byte
    end

    it "must add the Int32 to #byte_set" do
      expect(subject.byte_set.includes?(byte)).to be(true)
    end

    it "must add the char equivalent of the Int32 to #byte_set" do
      expect(subject.char_set.includes?(char)).to be(true)
    end
  end

  describe "#includes_char?" do
    it "must include Strings" do
      expect(subject.includes_char?('A')).to be(true)
    end
  end

  describe "#includes?(Int32)" do
    it "must include Ints32 values" do
      expect(subject).to contain(0x42)
    end
  end

  describe "#includes?(Char)" do
    it "must include Char values" do
      expect(subject).to contain('B')
    end
  end

  describe "#each_byte" do
    it "must yield each byte in the CharSet" do
      yielded_bytes = [] of Int32

      subject.each_byte do |b|
        yielded_bytes << b
      end

      expect(yielded_bytes).to eq(subject.bytes)
    end
  end

  describe "#each_char" do
    it "must yield each char in the CharSet" do
      yielded_chars = [] of Char

      subject.each_char do |c|
        yielded_chars << c
      end

      expect(yielded_chars).to eq(subject.chars)
    end
  end

  describe "#each" do
    it "must yield each char in the CharSet" do
      yielded_chars = [] of Char

      subject.each do |c|
        yielded_chars << c
      end

      expect(yielded_chars).to eq(subject.chars)
    end
  end

  describe "#select_bytes" do
    it "must be able to select bytes" do
      sub_set = subject.select_bytes { |c| c <= 0x42 }

      expect(sub_set).to be == [0x41, 0x42]
    end
  end

  describe "#select_chars" do
    it "must be able to select chars" do
      sub_set = subject.select_chars { |c| c <= 'B' }

      expect(sub_set).to be == ['A', 'B']
    end
  end

  describe "#select" do
    subject { described_class.new(['A', 'B', 'C']) }

    it "must select chars from the CharSet based on the given block" do
      expect(subject.select { |c| c > 'A' }).to eq(['B', 'C'])
    end
  end

  describe "#map_bytes" do
    subject { described_class.new([0x41, 0x42, 0x43]) }

    it "must map each byte in the CharSet using the given block" do
      expect(subject.map_bytes { |b| b + 1 }).to eq([0x42, 0x43, 0x44])
    end
  end

  describe "#map_chars" do
    subject { described_class.new(['A', 'B', 'C']) }

    it "must map each chars in the CharSet using the given block" do
      expect(subject.map_chars { |c| c - 'A' }).to eq([0, 1, 2])
    end
  end

  describe "#map" do
    subject { described_class.new(['A', 'B', 'C']) }

    it "must map each chars in the CharSet using the given block" do
      expect(subject.map_chars { |c| c - 'A' }).to eq([0, 1, 2])
    end
  end

  describe "#random_byte" do
    it "must return a random byte" do
      expect(subject).to contain(subject.random_byte)
    end
  end

  describe "#random_char" do
    it "must return a random char" do
      expect(subject.includes_char?(subject.random_char)).to be(true)
    end
  end

  describe "#each_random_byte" do
    it "must iterate over n random bytes" do
      random_bytes = [] of Int32

      subject.each_random_byte(10) { |b| random_bytes << b }

      expect(random_bytes.all? { |b| subject.includes_byte?(b) }).to be(true)
    end
  end

  describe "#each_random_char" do
    it "must iterate over n random chars" do
      random_chars = [] of Char

      subject.each_random_char(10) { |c| random_chars << c }

      expect(random_chars.all? { |c| subject.includes_char?(c) }).to be(true)
    end
  end

  describe "#random_bytes(Int)" do
    it "must return a random Array of bytes" do
      random_bytes = subject.random_bytes(10)

      expect(random_bytes.all? { |b| subject.includes?(b) }).to be(true)
    end
  end

  describe "#random_bytes(Range(Int, Int))" do
    it "must return a random Array of bytes with a varying length" do
      random_bytes = subject.random_bytes(5..10)

      expect(random_bytes.size).to be_between(5, 10)
      expect(random_bytes.all? { |b| subject.includes?(b) }).to be(true)
    end
  end

  describe "#random_chars(Int)" do
    it "must return a random Array of chars" do
      random_chars = subject.random_chars(10)

      expect(random_chars.all? { |c| subject.includes_char?(c) }).to be(true)
    end
  end

  describe "#random_chars(Range(Int, Int))" do
    it "must return a random Array of chars with a varying length" do
      random_chars = subject.random_chars(5..10)

      expect(random_chars.size).to be_between(5, 10)
      expect(random_chars.all? { |c| subject.includes_char?(c) }).to be(true)
    end
  end

  describe "#random_string" do
    it "must return a random String of chars" do
      random_string = subject.random_string(10)

      expect(random_string.chars.all? { |b|
        subject.includes_char?(b)
      }).to be(true)
    end

    context "with a range of lengths" do
      it "must return a random String of chars with a varying length" do
        string = subject.random_string(5..10)

        expect(string.size).to be_between(5, 10)
        expect(string.chars.all? { |b| subject.includes_char?(b) }).to be(true)
      end
    end
  end
  
  describe "#random_distinct_bytes" do
    it "must return a random Array of unique bytes" do
      bytes = subject.random_distinct_bytes(10)

      expect(bytes.uniq).to be == bytes
      expect(bytes.all? { |b| subject.includes?(b) }).to be(true)
    end

    context "with a range of lengths" do
      it "must return a random Array of unique bytes with a varying length" do
        bytes = subject.random_distinct_bytes(5..10)

        expect(bytes.uniq).to be == bytes
        expect(bytes.size).to be_between(5, 10)
        expect(bytes.all? { |b| subject.includes?(b) }).to be(true)
      end
    end
  end

  describe "#random_distinct_chars" do
    it "must return a random Array of unique chars" do
      chars = subject.random_distinct_chars(10)

      expect(chars.uniq).to be == chars
      expect(chars.all? { |c| subject.includes_char?(c) }).to be(true)
    end

    context "with a range of lengths" do
      it "must return a random Array of unique chars with a varying length" do
        chars = subject.random_distinct_chars(5..10)

        expect(chars.uniq).to be == chars
        expect(chars.size).to be_between(5, 10)
        expect(chars.all? { |c| subject.includes_char?(c) }).to be(true)
      end
    end
  end

  describe "#each_substring_with_index(&block : (String, Int32) ->)" do
    subject { described_class.new(['A', 'B', 'C']) }

    let(:string) { "....AAAA....BBBB....CCCC...." }

    it "must yield each matching substring and index" do
      yielded_args = [] of {String, Int32}

      subject.each_substring_with_index(string) do |substring,index|
        yielded_args << {substring, index}
      end

      expect(yielded_args).to eq(
        [
          {"AAAA", string.index("AAAA")},
          {"BBBB", string.index("BBBB")},
          {"CCCC", string.index("CCCC")}
        ]
      )
    end

    context "when the string begins with a matching substring" do
      let(:string) { "AAAA...." }

      it "must yield the first matching substring" do
        yielded_args = [] of {String, Int32}

        subject.each_substring_with_index(string) do |substring,index|
          yielded_args << {substring, index}
        end

        expect(yielded_args.first).to eq({"AAAA", 0})
      end
    end

    context "when the string ends with a matching substring" do
      let(:string) { "AAAA....BBBB....CCCC" }

      it "must yield the last matching substring" do
        yielded_args = [] of {String, Int32}

        subject.each_substring_with_index(string) do |substring,index|
          yielded_args << {substring, index}
        end

        expect(yielded_args.last).to eq({"CCCC", string.rindex("CCCC")})
      end
    end

    context "when the entire string is a matching substring" do
      let(:string) { "AAAAAAAA" }

      it "must yield the entire string" do
        yielded_args = [] of {String, Int32}

        subject.each_substring_with_index(string) do |substring,index|
          yielded_args << {substring, index}
        end

        expect(yielded_args).to eq([ {string, 0} ])
      end
    end

    context "when the matching substrings are shorter than the min_length" do
      let(min_length) { 2 }

      let(string) { "AA..B...CC.."}

      it "must ignore the substrings shorter than min_length" do
        yielded_args = [] of {String, Int32}

        subject.each_substring_with_index(string,min_length) do |substring,index|
          yielded_args << {substring, index}
        end

        expect(yielded_args).to eq(
          [
            {"AA", string.index("AA")},
            {"CC", string.index("CC")}
          ]
        )
      end
    end

    context "when min_length 0" do
      let(min_length) { 0 }

      let(string) { "A.BB..CCC..."}

      it "must yield all matching substrings, regardless of length" do
        yielded_args = [] of {String, Int32}

        subject.each_substring_with_index(string,min_length) do |substring,index|
          yielded_args << {substring, index}
        end

        expect(yielded_args).to eq(
          [
            {"A",   string.index("A")},
            {"BB",  string.index("BB")},
            {"CCC", string.index("CCC")}
          ]
        )
      end
    end
  end

  describe "#substrings_with_indexes" do
    subject { described_class.new(['A', 'B', 'C']) }

    let(:string) { "....AAAA....BBBB....CCCC...." }

    it "must return the Array of substrings and their indexes" do
      expect(subject.substrings_with_indexes(string)).to eq(
        [
          {"AAAA", string.index("AAAA")},
          {"BBBB", string.index("BBBB")},
          {"CCCC", string.index("CCCC")}
        ]
      )
    end
  end

  describe "#each_substring(&block : (String) ->)" do
    subject { described_class.new(['A', 'B', 'C']) }

    let(:string) { "....AAAA....BBBB....CCCC...." }

    it "must yield each matching substring" do
      yielded_args = [] of String

      subject.each_substring(string) do |substring|
        yielded_args << substring
      end

      expect(yielded_args).to eq(
        [
          "AAAA",
          "BBBB",
          "CCCC"
        ]
      )
    end
  end

  describe "#substrings" do
    subject { described_class.new(['A', 'B', 'C']) }

    let(:string) { "....AAAA....BBBB....CCCC...." }

    it "must return the Array of matching substrings" do
      yielded_args = [] of String

      expect(subject.substrings(string)).to eq(
        [
          "AAAA",
          "BBBB",
          "CCCC"
        ]
      )
    end
  end

  describe "#substrings" do
    it "must find one sub-string from a String belonging to the char set" do
      expect(subject.substrings("AAAA")).to be == ["AAAA"]
    end

    it "must find sub-strings from a String belonging to the char set" do
      expect(subject.substrings("AAAA!B!CCCCCC")).to be == [
        "AAAA",
        "CCCCCC"
      ]
    end
  end

  describe "#|" do
    subject { described_class.new(['A', 'B', 'C']) }

    let(other) { described_class.new(['B', 'C', 'D']) }

    it "must unioned the chars from another CharSet with the CharSet" do
      expect(subject | other).to eq(described_class.new(['A', 'B', 'C', 'D']))
    end
  end

  describe "#+" do
  end

  describe "#-" do
    it "must be able to be removed from another set of chars" do
      sub_set = (subject - described_class['A'])

      expect(sub_set).to be_kind_of(described_class)
      expect(sub_set.includes_char?('A')).to be(false)
    end
  end

  describe "#&" do
    context "when the two CharSets contain common characters" do
      subject { described_class.new(['A', 'B', 'C']) }

      let(other) { described_class.new(['B', 'C', 'D']) }

      it "must return the intersection of the two char sets" do
        expect(subject & other).to eq(described_class.new(['B', 'C']))
      end
    end

    context "when the two CharSets do not contain any common characters" do
      subject { described_class.new(['A', 'B', 'C']) }

      let(char_set2) { described_class.new(['X', 'Y', 'Z']) }

      it do
        expect(subject & char_set2).to eq(described_class.new([] of Char))
      end
    end
  end

  describe "#intersects?" do
    context "when the two CharSets contain common characters" do
      subject { described_class.new(['A', 'B', 'C']) }

      let(other) { described_class.new(['B', 'C', 'D']) }

      it do
        expect(subject.intersects?(other)).to be(true)
      end
    end

    context "when the two CharSets do not contain any common characters" do
      subject { described_class.new(['A', 'B', 'C']) }

      let(other) { described_class.new(['X', 'Y', 'Z']) }

      it do
        expect(subject.intersects?(other)).to be(false)
      end
    end
  end

  describe "#subset_of?" do
    context "when all of the CharSet characters belongs to the other CharSet" do
      subject { described_class.new(['A', 'B']) }

      let(other) { described_class.new(['A', 'B', 'C']) }

      it do
        expect(subject.subset_of?(other)).to be(true)
      end
    end

    context "when the CharSet contains additional characters" do
      subject { described_class.new(['A', 'B', 'C']) }

      let(other) { described_class.new(['A', 'B']) }

      it do
        expect(subject.subset_of?(other)).to be(false)
      end
    end

    context "when the two CharSets do not contain any common characters" do
      subject { described_class.new(['A', 'B', 'C']) }

      let(other) { described_class.new(['X', 'Y', 'Z']) }

      it do
        expect(subject.subset_of?(other)).to be(false)
      end
    end
  end

  describe "#==" do
    it "must be able to be compared with another set of chars" do
      expect(subject).to be == described_class['A'..'Z']
    end
  end

  describe "#===" do
    subject { described_class.new(['A', 'B', 'C']) }

    context "when every char in the String also belongs to the CharSet" do
      let(string) { "ABCABCABC" }

      it { expect(subject === string).to be(true) }
    end

    context "when the String contains a char not in the CharSet" do
      let(string) { "ABCABCABCX" }

      it { expect(subject === string).to be(false) }
    end
  end

  describe "#~" do
  end
end
