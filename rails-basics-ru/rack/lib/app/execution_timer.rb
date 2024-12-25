# frozen_string_literal: true
require 'benchmark'

class ExecutionTimer
  def initialize(app)
    @app = app
    @status = ''
    @headers = {}
    @body = []
  end

  def call(env)
    time = Benchmark.measure do
      @status, @headers, @body = @app.call(env)
    end

    @headers['X-Runtime-Microseconds'] = time.to_s
    [@status, @headers, @body]
  end
end