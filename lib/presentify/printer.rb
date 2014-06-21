class Presentify
  class Printer
    def initialize
      @screen = Screen.new
      @colorifer = Colorifer.new
    end

    def show(slide)
      load_up slide do
        print_title
        print_code
      end
    end

    def demo(slide)
      load_up slide do
        print_title
        @demo_thread = Thread.new do
          eval slide.code
        end
        @demo_thread.join(0.01)
      end
    end

  private

    def load_up(slide, &block)
      @demo_thread.kill if @demo_thread
      @screen.clear
      @current_slide = slide

      block.call
    end

    def print_title
      print "\e[33m== #{@current_slide.head} ==\e[0m\n\n"
    end

    def print_code
      code = @colorifer.colorify(@current_slide.code)
      print "#{code}\n\n\n"
    end

    def puts(str)
      STDOUT.puts str.gsub("\n", "\n\r")
    end

    def print(str)
      STDOUT.print str.gsub("\n", "\n\r")
    end
  end
end
