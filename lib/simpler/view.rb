require 'erb'
require_relative 'render/render_plain'
require_relative 'render/render_erb'

module Simpler
  class View
    # RENDER_TABLE =
    #   {
    #     erb: 'Simpler::RenderErb.new(env)',
    #     plain: 'Simpler::RenderPlain.new(env)'
    #   }.freeze

    def initialize(env)
      type = env['simpler.type_render']
      # @render = eval(RENDER_TABLE[type])
      @render = Simpler.const_get("Render#{type.capitalize}").new(env)
    end

    def render(binding)
      @render.call(binding)
    end
  end
end
