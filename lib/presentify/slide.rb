class Presentify
  class Slide
    attr_reader :head, :code

    def initialize(content)
      @head, @code = parse(content)
    end

  private

    HEAD_RE = /\A#([^\n]+)\n/
    CODE_RE = /\A#[^\n]+\n([\s\S]+)/

    def parse(content)
      [HEAD_RE, CODE_RE].map do |re|
        content.scan(re)[0][0].strip
      end
    end
  end
end
