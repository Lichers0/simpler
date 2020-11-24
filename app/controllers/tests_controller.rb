class TestsController < Simpler::Controller

  def index
    @time = Time.now
  end

  def create

  end

  def plain
    render plain: "test"
  end

  def show_param_id
    render plain: "show #{params[:id]}"
  end
end
