module Chars
  class CharSet

    include Enumerable(Char)

    getter byte_set : Set(Int32)
    getter char_set : Set(Char)

    #
    # Initializes an empty `CharSet`.
    #
    def initialize
      @byte_set = Set(Int32).new
      @char_set = Set(Char).new
    end

    #
    # Initializes the `CharSet` using the list of bytes or chars.
    #
    def initialize(values : Enumerable(UInt8 | Int32 | Char))
      initialize()

      values.each do |value|
        self << value
      end
    end

    #
    # Initializes the `CharSet` using the list of bytes or chars.
    #
    def initialize(values : Indexable(UInt8 | Int32 | Char))
      @byte_set = Set(Int32).new(values.size)
      @char_set = Set(Char).new(values.size)

      values.each do |value|
        self << value
      end
    end

    #
    # Creates a new `CharSet` using the list of chars, bytes, or ranges of
    # chars/bytes.
    #
    def self.[](*values : UInt8 | Int32 | Char | Range(UInt8, UInt8) |
                                                 Range(Int32, Int32) |
                                                 Range(Char, Char)) : CharSet
      char_set = new()

      values.each do |value|
        case value
        when Range
          value.each { |v| char_set << v }
        else
          char_set << value
        end
      end

      return char_set
    end

    #
    # The byte values within the `CharSet`.
    #
    def bytes : Array(Int32)
      @byte_set.to_a
    end

    #
    # The character values within the `CharSet`.
    #
    def chars : Array(Char)
      @char_set.to_a
    end

    #
    # Appends a new character to the `CharSet`.
    #
    def <<(value : Char) : CharSet
      @char_set << value
      @byte_set << value.ord
      return self
    end

    #
    # Appends a new byte value to the `CharSet`.
    #
    def <<(value : UInt8) : CharSet
      self << value.to_i32
    end

    #
    # Appends a new byte value to the `CharSet`.
    #
    def <<(value : Int32) : CharSet
      @char_set << value.chr
      @byte_set << value
      return self
    end

    #
    # Determines if the given byte exists in the `CharSet`.
    #
    def includes_byte?(byte : UInt8) : Bool
      includes_byte?(byte.to_i32)
    end

    #
    # Determines if the given byte exists in the `CharSet`.
    #
    def includes_byte?(byte : Int32) : Bool
      @byte_set.includes?(byte)
    end

    #
    # Determines if the given char exists in the `CharSet`.
    #
    def includes_char?(char : Char) : Bool
      @char_set.includes?(char)
    end

    #
    # See `#includes_byte?`.
    #
    @[AlwaysInline]
    def includes?(byte : Int32) : Bool
      includes_byte?(byte)
    end

    #
    # See `#includes_char?`.
    #
    @[AlwaysInline]
    def includes?(char : Char) : Bool
      includes_char?(char)
    end

    #
    # Enumerates over each byte within the `CharSet`.
    #
    def each_byte(&block : (Int32) ->)
      @byte_set.each(&block)
    end

    #
    # Enumerates over each char within the `CharSet`.
    #
    def each_char(&block : (Char) ->)
      @char_set.each(&block)
    end

    delegate each, to: @char_set

    #
    # Selects the bytes within the `CharSet` that match the given block.
    #
    def select_bytes(&block : (Int32) -> Bool) : Array(Int32)
      @byte_set.select(&block)
    end

    #
    # Selects the chars within the `CharSet` that match the given block.
    #
    def select_chars(&block : (Char) -> Bool) : Array(Char)
      @char_set.select(&block)
    end

    delegate :select, to: @char_set

    #
    # Maps the bytes within the `CharSet` using the given block.
    #
    def map_bytes(&block : (Int32) -> T) : Array(T) forall T
      @byte_set.map(&block)
    end

    #
    # Maps the chars within the `CharSet` using the given block.
    #
    def map_chars(&block : (Char) -> T) : Array(T) forall T
      @char_set.map(&block)
    end

    delegate map, to: @char_set

    #
    # Returns a random byte from the `CharSet`.
    #
    def random_byte : Int32
      @byte_set.sample
    end

    #
    # Returns a random char from the `CharSet`.
    #
    def random_char : Char
      @char_set.sample
    end

    #
    # Enumerates over `n` random bytes from the `CharSet`.
    #
    def each_random_byte(n : Int, &block : (Int32) ->)
      n.times { yield random_byte }
    end

    #
    # Enumerates over `n` random chars from the `CharSet`.
    #
    def each_random_char(n : Int, &block : (Char) ->)
      n.times { yield random_char }
    end

    #
    # Returns an Array of `n` random bytes from the `CharSet`.
    #
    def random_bytes(length : Int) : Array(Int32)
      @byte_set.sample(length)
    end

    #
    # Returns an Array of random bytes from the `CharSet`.
    #
    def random_bytes(lengths : Array(Int) | Range(Int, Int)) : Array(Int32)
      Array(Int32).new(lengths.sample) do
        random_byte
      end
    end

    #
    # Returns an Array of random chars from the `CharSet`.
    #
    def random_chars(length : Int) : Array(Char)
      @char_set.sample(length)
    end

    #
    # Returns an Array of random chars from the `CharSet`.
    #
    def random_chars(lengths : Array(Int) | Range(Int, Int)) : Array(Char)
      Array(Char).new(lengths.sample) do
        random_char
      end
    end

    #
    # Returns a String of random chars from the `CharSet`.
    #
    def random_string(length : Int | Array(Int) | Range(Int, Int)) : String
      random_chars(length).join
    end

    #
    # Returns an Array of random, but unique, bytes from the `CharSet`.
    #
    def random_distinct_bytes(length : Int) : Array(Int32)
      @byte_set.to_a.shuffle[0,length]
    end

    #
    # Returns an Array of random, but unique, bytes from the `CharSet`.
    #
    def random_distinct_bytes(length : Array(Int)) : Array(Int32)
      bytes.shuffle[0,length.sample]
    end

    #
    # Returns an Array of random, but unique, bytes from the `CharSet`.
    #
    def random_distinct_bytes(length : Range(Int, Int)) : Array(Int32)
      @byte_set.to_a.shuffle[0,rand(length)]
    end

    #
    # Returns an Array of random, but unique, chars from the `CharSet`.
    #
    def random_distinct_chars(length : Int) : Array(Char)
      @char_set.to_a.shuffle[0,length]
    end

    #
    # Returns an Array of random, but unique, chars from the `CharSet`.
    #
    def random_distinct_chars(length : Array(Int)) : Array(Char)
      chars.shuffle[0,length.sample]
    end

    #
    # Returns an Array of random, but unique, chars from the `CharSet`.
    #
    def random_distinct_chars(length : Range(Int,Int)) : Array(Char)
      @char_set.to_a.shuffle[0,rand(length)]
    end

    #
    # Returns a String of random, but unique, chars from the `CharSet`.
    #
    def random_distinct_string(length : Int | Array(Int) | Range(Int, Int)) : String
      random_distinct_chars(length).join
    end

    #
    # Enumerates over all substrings and their indices within the given string,
    # of minimum length and that are made up of characters from the `CharSet`.
    #
    def each_substring_with_index(data : String, min_length : Int = 4, &block : (String, Int32) ->)
      return if data.size < min_length

      index : Int32 = 0

      match_start : Int32? = nil
      match_end   : Int32? = nil

      while index < data.size
        unless match_start
          if includes_char?(data[index])
            match_start = index
          end
        else
          unless includes_char?(data[index])
            match_end    = index
            match_length = (match_end - match_start)

            if match_length >= min_length
              match = data[match_start,match_length]

              yield match, match_start
            end

            match_start = match_end = nil
          end
        end

        index += 1
      end

      # yield the remaining match
      if match_start
        yield data[match_start, data.size - match_start], match_start
      end
    end

    #
    # Returns an Array of all substrings and their indices within the given
    # string, of minimum length and that are made up of characters from the
    # `CharSet`.
    #
    def substrings_with_indexes(data : String, min_length : Int = 4) : Array(Tuple(String, Int32))
      array = [] of Tuple(String, Int32)

      each_substring_with_index(data,min_length) do |substring,index|
        array << {substring, index}
      end

      return array
    end

    #
    # Enumerates over all substrings within the given string, of minimum length
    # and that are made up of characters from the `CharSet`.
    #
    def each_substring(data : String, min_length : Int = 4, &block : (String) ->)
      each_substring_with_index(data,min_length) do |substring,index|
        yield substring
      end
    end

    #
    # Returns an Array of all substrings within the given string,
    # of minimum length and that are made up of characters from the `CharSet`.
    #
    def substrings(data : String, min_length : Int = 4) : Array(String)
      array = [] of String

      each_substring(data,min_length) do |substring|
        array << substring
      end

      return array
    end

    #
    # Unions the `CharSet` with another `CharSet`, returning a new `CharSet`.
    #
    def |(other : CharSet) : CharSet
      CharSet.new(@char_set | other.@char_set)
    end

    #
    # See `#+`.
    #
    @[AlwaysInline]
    def +(other : CharSet) : CharSet
      self | other
    end

    #
    # Subtracts the characters of another `CharSet` from the `CharSet`,
    # returning a new `CharSet`.
    #
    def -(other : CharSet) : CharSet
      CharSet.new(@char_set - other.@char_set)
    end

    #
    # Intersects the `CharSet` with another `CharSet`, returning a new `CharSet`.
    #
    def &(other : CharSet) : CharSet
      CharSet.new(@char_set & other.@char_set)
    end

    #
    # Determines whether the `CharSet` intersects with another `CharSet`.
    #
    def intersects?(other : CharSet) : Bool
      @char_set.any? { |char| other.includes_char?(char) }
    end

    #
    # Determines whether the other `CharSet` is a sub-set of the `CharSet`.
    #
    def subset_of?(other : CharSet) : Bool
      @char_set.all? { |char| other.includes_char?(char) }
    end

    #
    # Determines whether the `CharSet` is equal to another `CharSet`.
    #
    def ==(other : CharSet) : Bool
      @char_set == other.@char_set
    end

    #
    # Determines whether all characters in a given string also belong to the
    # `CharSet`.
    #
    def ===(other : String) : Bool
      if other.valid_encoding?
        other.chars.all? { |char| includes_char?(char) }
      else
        other.bytes.all? { |byte| includes_byte?(byte.to_i32) }
      end
    end

    #
    # See `#===`.
    #
    @[AlwaysInline]
    def =~(string : String)
      self === string
    end

    delegate to_a, to: @char_set
    delegate to_set, to: @char_set

  end
end
