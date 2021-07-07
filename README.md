# Chars

[![CI](https://github.com/postmodern/chars.cr/actions/workflows/crystal.yml/badge.svg)](https://github.com/postmodern/chars.cr/actions/workflows/crystal.yml)

* [Source](https://github.com/postmodern/chars.cr#readme)
* [Issues](https://github.com/postmodern/chars.cr/issues)
* [Documentation](https://postmodern.github.io/docs/chars.cr)
* [Email](mailto:postmodern.mod3 at gmail.com)

## Description

Chars is a [Crystal] library for working with various character sets,
recognizing text and generating random text from specific character sets.
Ported from the [chars.rb] ruby library.

## Features

* Provides character sets for:
  * Numeric: `0` - `9`
  * Octal: `0` - `7`
  * Uppercase Hexadecimal: `0` - `9`, `A` - `F`
  * Lowercase Hexadecimal: `0` - `9`, `a` - `f`
  * Hexadecimal: `0` - `9`, `a` - `f`, `A` - `F`
  * Uppercase Alpha: `A` - `Z`
  * Lowercase Alpha: `a` - `z`
  * Alpha: `a` - `z`, `A` - `Z`
  * Alpha-numeric: `0` - `9`, `a` - `z`, `A` - `Z`
  * Punctuation: `' '`, `'`, `"`, ```, `,`, `;`, `:`, `~`, `-`, `(`, `)`, `[`, `]`, `{`, `}`, `.`, `?`, `!`
  * Symbols: `' '`, `'`, `"`, ```, `,`, `;`, `:`, `~`, `-`, `(`, `)`, `[`, `]`, `{`, `}`, `.`, `?`, `!`, `@`, `#`, `$`, `%`, `^`, `&`, `*`, `_`, `+`, `=`, `|`, `\`, `<`, `>`, `/`
  * Space: `' '`, `\f`, `\n`, `\r`, `\t`, `\v`
  * Visible: `0` - `9`, `a` - `z`, `A` - `Z`, `'`, `"`, ```, `,`, `;`, `:`, `~`, `-`, `(`, `)`, `[`, `]`, `{`, `}`, `.`, `?`, `!`, `@`, `#`, `$`, `%`, `^`, `&`, `\*`, `\_`, `+`, `=`, `|`, `\`, `<`, `>`, `/`
  * Printable: `0` - `9`, `a` - `z`, `A` - `Z`, `' '`, `'`, `"`, ```, `,`, `;`, `:`, `~`, `-`, `(`, `)`, `[`, `]`, `{`, `}`, `.`, `?`, `!`, `@`, `#`, `$`, `%`, `^`, `&`, `*`, `_`, `+`, `=`, `|`, `\`, `<`, `>`, `/`, `\f`, `\n`, `\r`, `\t`, `\v`
  * Control: `\x00` - \x1f`, `\x7f`
  * Signed ASCII: `\x00` - `\x7f`
  * ASCII: `\x00` - `\xff`

## Examples

Determine whether a byte belongs to a character set:

    0x41.alpha?
    # => true

Determine whether a String belongs to a character set:

    "22e1c0".hex?
    # => true

Find all sub-strings that belong to a character set within a String:

    ls = File.read("/bin/ls")
    Chars.printable.substrings(ls)
    # => ["/lib64/ld-linux-x86-64.so.2", "KIq/", "5J~!", "%L~!", ...]

Return a random character from the set of all characters:

    Chars.all.random_char
    # => "\x94"

Return a random Array of characters from the alpha-numeric character set:

    Chars.alpha_numeric.random_chars(10)
    # => ["Q", "N", "S", "4", "x", "z", "3", "M", "F", "F"]

Return a random Array of a random length of unique characters from the
visible character set:

    Chars.visible.random_distinct_chars(1..10)
    # => ["S", "l", "o", "8", "'", "q"]

Return a random String from the set of all characters:

    Chars.all.random_string(10)
    # => "\xc2h\xad\xccm7\x1e6J\x13"

Return a random String with a random length between 5 and 10, from the
set of space characters:

    Chars.space.random_string(5..10)
    # => "\r\v\n\t\n\f"

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     chars:
       github: postmodern/chars.cr
   ```

2. Run `shards install`

## Contributing

1. Fork it (<https://github.com/postmodern/chars.cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Postmodern](https://github.com/postmodern) - creator and maintainer

[Crystal]: https://crystal-lang.org/
[chars.rb]: https://github.com/postmodern/chars.rb
