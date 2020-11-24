require_relative 'abstract_render'
module Simpler
  class RenderPlain < AbstractRender
    def call(binding)
      @env['simpler.plain']
    end
  end
end

