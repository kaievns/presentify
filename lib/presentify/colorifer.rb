class Presentify
  class Colorifer
    RED     = 1
    GREEN   = 2
    YELLOW  = 3
    BLUE    = 4
    MAGENTA = 5
    CYAN    = 6
    WHITE   = 7

    CONSTANTS_RE        = /true|false|nil/
    SINGLE_STRINGS_RE   = /('|").*?((?![\\])\1)/
    MUTLTI_STRINGS_RE   = /%(Q|w)[\{\[]([\s\S]*?)[\]\}]/m
    KEYWORDS_RE         = /while|do|end|sleep|puts|print/
    METHOD_CALLS_RE     = /\.[a-z_]+/
    ESCAPE_CODES_RE     = /\\(r|b|n|(e\[[\d\;]+(m|A)))/
    INTERPOLATIONS_RE   = /\#\{.+?\}/

    def colorify(code)
      #code = code.gsub NUMBERS_RE, "\e[3#{RED}m\\2\e[0m\\3"

      replacify code.dup, {
        CONSTANTS_RE        => RED,
        ESCAPE_CODES_RE     => YELLOW,
        INTERPOLATIONS_RE   => YELLOW,
        MUTLTI_STRINGS_RE   => GREEN,
        SINGLE_STRINGS_RE   => GREEN,
        KEYWORDS_RE         => MAGENTA,
        METHOD_CALLS_RE     => CYAN
      }
    end

  private

    def replacify(code, res)
      stash = []

      # applying colors
      res.each do |re, color|
        while code.match(re)
          match = $&.dup
          code.sub! match, placeholder(stash.size)
          replacement = "\e[3#{color}m#{match}\e[0m"
          replacement << "\e[3#{GREEN}m" if re == ESCAPE_CODES_RE || re == INTERPOLATIONS_RE
          stash << replacement
        end
      end

      # rollback
      while entry = stash.pop
        code.sub! placeholder(stash.size), entry
      end

      code
    end

    def placeholder(num)
      "-----placeholder-#{num}----"
    end
  end
end
