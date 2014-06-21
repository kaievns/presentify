class Presentify
  class Keyboard
    def initialize(&block)
      @listeners = []
      block.call(self)
      Thread.new { watch_keyboard }.join
    end

    def on(key, &block)
      @listeners << [key, block]
    end

    def trigger(key)
      @listeners.each do |entry|
        if entry[0] == key
          entry[1].call
        end
      end
    end

  private

    def watch_keyboard
      while true
        case ch = read_key
        when "\e[A" then trigger :up
        when "\e[B" then trigger :down
        when "\e[C" then trigger :right
        when "\e[D" then trigger :left
        when "\r", "\n" then trigger :enter
        when "\e", "\u0003" then system("clear") && exit(0)
        # else puts "You pressed: #{ch.inspect}\n"
        end
      end
    end

    def read_key
      old_state = `stty -g`
      `stty raw -echo`

      c = STDIN.getc.chr

      if c == "\e" # reading escape sequences
        extra_thread = Thread.new do
          c += STDIN.getc.chr + STDIN.getc.chr
        end
        extra_thread.join(0.001)
        extra_thread.kill
      end

      c

    ensure
      `stty #{old_state}`
    end
  end
end
