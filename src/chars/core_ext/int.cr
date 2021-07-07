require "../../chars"

struct Int

  #
  # Determines if the byte belongs to the decimal-digit character set.
  #
  # See `Chars::NUMERIC` and `Chars::CharSet#===`.
  #
  def numeric?
    Chars::NUMERIC.includes_byte?(self)
  end

  #
  # Determines if the byte belongs to the octal-digit character set.
  #
  # See `Chars::OCTAL` and `Chars::CharSet#===`.
  #
  def octal?
    Chars::OCTAL.includes_byte?(self)
  end

  #
  # Determines if the byte belongs to the upper-case hexadecimal character
  # set.
  #
  # See `Chars::UPPERCASE_HEXADECIMAL` and `Chars::CharSet#===`.
  #
  def uppercase_hex?
    Chars::UPPERCASE_HEXADECIMAL.includes_byte?(self)
  end

  #
  # Determines if the byte belongs to the lower-case hexadecimal character
  # set.
  #
  # See `Chars::LOWERCASE_HEXADECIMAL` and `Chars::CharSet#===`.
  #
  def lowercase_hex?
    Chars::LOWERCASE_HEXADECIMAL.includes_byte?(self)
  end

  #
  # Determines if the byte belongs to the hexadecimal character set.
  #
  # See `Chars::HEXADECIMAL` and `Chars::CharSet#===`.
  #
  def hex?
    Chars::HEXADECIMAL.includes_byte?(self)
  end

  #
  # Determines if the byte belongs to the upper-case alphabetic character
  # set.
  #
  # See `Chars::UPPERCASE_ALPHA` and `Chars::CharSet#===`.
  #
  def uppercase_alpha?
    Chars::UPPERCASE_ALPHA.includes_byte?(self)
  end

  #
  # Determines if the byte belongs to the lower-case alphabetic character
  # set.
  #
  # See `Chars::LOWERCASE_ALPHA` and `Chars::CharSet#===`.
  #
  def lowercase_alpha?
    Chars::LOWERCASE_ALPHA.includes_byte?(self)
  end

  #
  # Determines if the byte belongs to the alphabetic character set.
  #
  # See `Chars::ALPHA` and `Chars::CharSet#===`.
  #
  def alpha?
    Chars::ALPHA.includes_byte?(self)
  end

  #
  # Determines if the byte belongs to the alpha-numeric character set.
  #
  # See `Chars::ALPHA_NUMERIC` and `Chars::CharSet#===`.
  #
  def alpha_numeric?
    Chars::ALPHA_NUMERIC.includes_byte?(self)
  end

  #
  # Determines if the byte belongs to the punctuation character set.
  #
  # See `Chars::PUNCTUATION` and `Chars::CharSet#===`.
  #
  def punctuation?
    Chars::PUNCTUATION.includes_byte?(self)
  end

  #
  # Determines if the byte belongs to the symbolic character set.
  #
  # See `Chars::SYMBOLS` and `Chars::CharSet#===`.
  #
  def symbolic?
    Chars::SYMBOLS.includes_byte?(self)
  end

  #
  # Determines if the byte belongs to the white-space character set.
  #
  # See `Chars::SPACE` and `Chars::CharSet#===`.
  #
  def space?
    Chars::SPACE.includes_byte?(self)
  end

  #
  # Determines if the byte belongs to the visible character set.
  #
  # See `Chars::VISIBLE` and `Chars::CharSet#===`.
  #
  def visible?
    Chars::VISIBLE.includes_byte?(self)
  end

  #
  # Determines if the byte belongs to the printable character set.
  #
  # See `Chars::PRINTABLE` and `Chars::CharSet#===`.
  #
  def printable?
    Chars::PRINTABLE.includes_byte?(self)
  end

  #
  # Determines if the byte belongs to the control-character character set.
  #
  # See `Chars::CONTROL` and `Chars::CharSet#===`.
  #
  def control?
    Chars::CONTROL.includes_byte?(self)
  end

  #
  # Determines if the byte belongs to the signed-ASCII character set.
  #
  # See `Chars::SIGNED_ASCII` and `Chars::CharSet#===`.
  #
  def signed_ascii?
    Chars::SIGNED_ASCII.includes_byte?(self)
  end

  #
  # Determines if the byte belongs to the ASCII character set.
  #
  # See `Chars::ASCII` and `Chars::CharSet#===`.
  #
  def ascii?
    Chars::ASCII.includes_byte?(self)
  end

end
