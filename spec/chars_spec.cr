require "./spec_helper"
require "../src/chars"

Spectator.describe Chars do
  describe "NUMERIC" do
    subject { Chars::NUMERIC }

    it "should provide a numeric CharSet" do
      expect(subject).to be =~ "0123456789"
    end
  end

  describe "OCTAL" do
    subject { Chars::OCTAL }

    it "should provide an octal CharSet" do
      expect(subject).to be =~ "01234567"
    end
  end

  describe "UPPERCASE_HEXADECIMAL" do
    subject { Chars::UPPERCASE_HEXADECIMAL }

    it "should provide an upper-case hexadecimal CharSet" do
      expect(subject).to be =~ "0123456789ABCDEF"
    end
  end

  describe "LOWERCASE_HEXADECIMAL" do
    subject { Chars::LOWERCASE_HEXADECIMAL }

    it "should provide a lower-case hexadecimal CharSet" do
      expect(subject).to be =~ "0123456789abcdef"
    end
  end

  describe "HEXADECIMAL" do
    subject { Chars::HEXADECIMAL }

    it "should provide a hexadecimal CharSet" do
      expect(subject).to be =~ "0123456789ABCDEFabcdef"
    end
  end

  describe "UPPERCASE_ALPHA" do
    subject { Chars::UPPERCASE_ALPHA }

    it "should provide an upper-case alpha CharSet" do
      expect(subject).to be =~ "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    end
  end

  describe "LOWERCASE_ALPHA" do
    subject { Chars::LOWERCASE_ALPHA }

    it "should provide a lower-case alpha CharSet" do
      expect(subject).to be =~ "abcdefghijklmnopqrstuvwxyz"
    end
  end

  describe "ALPHA" do
    subject { Chars::ALPHA }

    it "should provide an alpha CharSet" do
      expect(subject).to be =~ "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    end
  end

  describe "ALPHA_NUMERIC" do
    subject { Chars::ALPHA_NUMERIC }

    it "should provide an alpha-numeric CharSet" do
      expect(subject).to be =~ "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    end
  end
  
  describe "VISIBLE" do
    subject { Chars::VISIBLE }

    it "should provide a visible CharSet" do
      expect(subject).to be =~ "!\"\#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"
    end
  end

  describe "SPACE" do
    subject { Chars::SPACE }

    it "should provide a space CharSet" do
      expect(subject).to be =~ "\t\n\v\f\r "
    end
  end

  describe "PUNCTUATION" do
    subject { Chars::PUNCTUATION }
    
    it "should provide a punctuation CharSet" do
      expect(subject).to be =~ " !\"'(),-.:;?[]`{}~"
    end
  end

  describe "SYMBOLS" do
    subject { Chars::SYMBOLS }

    it "should provide a symbols CharSet" do
      expect(subject).to be =~ " !\"\#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"
    end
  end
end
