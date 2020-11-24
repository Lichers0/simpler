class Simpler::AbstractRender
  def initialize(env)
    @env = env
  end

  def call(binding)
    raise NotImplementedError, "method :#{__method__} undefined for #{self}"
  end
end
