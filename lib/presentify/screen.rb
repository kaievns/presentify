class Presentify
  class Screen
    attr_reader :width, :height

    def initialize
      @height, @width = `stty -a`.scan(/(\d+) rows.+?(\d+) columns/)[0]
    end

    def clear
      system "clear"
    end
  end
end
