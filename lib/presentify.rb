require "presentify/slide"
require "presentify/screen"
require "presentify/printer"
require "presentify/keyboard"
require "presentify/colorifer"

class Presentify
  def initialize(directory, start_page=1)
    @page    = start_page
    @slides  = read(directory)
    @printer = Printer.new

    show_code @page

    Keyboard.new do |keyboard|
      keyboard.on(:up)    { show_code }
      keyboard.on(:down)  { show_demo }
      keyboard.on(:left)  { show_prev }
      keyboard.on(:right) { show_next }
    end
  end

  def show_next
    show_code @page += 1 if @slides.size > @page + 1
  end

  def show_prev
    show_code @page -= 1 if @page > 1
  end

  def show_code(page=@page)
    @printer.show @slides[@page = page]
  end

  def show_demo(page=@page)
    @printer.demo @slides[@page = page]
  end

private

  def read(directory)
    [nil] + (1..999).map do |num|
      if File.exists?("#{directory}/#{num}.rb")
        Slide.new(File.read("#{directory}/#{num}.rb"))
      end
    end.compact
  end
end
