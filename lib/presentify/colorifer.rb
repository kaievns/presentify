class Presentify
  class Colorifer
    RED     = 31
    GREEN   = 32
    YELLOW  = 33
    BLUE    = 34
    MAGENTA = 35
    CYAN    = 36
    WHITE   = 37
    GRAY    = 2

    CONSTANTS_RE        = /true|false|nil/
    SINGLE_STRINGS_RE   = /('|").*?((?![\\])\1)/
    MUTLTI_STRINGS_RE   = /%(Q|w)[\{\[]([\s\S]*?)[\]\}]/m
    COMMENTS_RE         = /# [^\n|\Z]+/
    KEYWORDS_RE         = /(\s|\n|\A)(while|do|end|sleep|puts|print|if|unless|else|def|class|ensure|rescue|yield)/
    METHOD_CALLS_RE     = /\.[a-z_]+/
    ESCAPE_CODES_RE     = /\\(r|b|n|(e\[[\d\;]+(m|A)))/
    INTERPOLATIONS_RE   = /\#\{.+?\}/
    CLASSES_RE          = /[A-Z][a-zA-Z_]+/

    def colorify(code)
      #code = code.gsub NUMBERS_RE, "\e[3#{RED}m\\2\e[0m\\3"

      replacify code.dup, {
        CONSTANTS_RE        => RED,
        ESCAPE_CODES_RE     => YELLOW,
        INTERPOLATIONS_RE   => YELLOW,
        MUTLTI_STRINGS_RE   => GREEN,
        SINGLE_STRINGS_RE   => GREEN,
        COMMENTS_RE         => GRAY,
        KEYWORDS_RE         => MAGENTA,
        METHOD_CALLS_RE     => CYAN,
        CLASSES_RE          => YELLOW
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
          replacement = "\e[#{color}m#{match}\e[0m"
          replacement << "\e[#{GREEN}m" if re == ESCAPE_CODES_RE || re == INTERPOLATIONS_RE
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
