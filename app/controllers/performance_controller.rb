class PerformanceController < ApplicationController
  before_action :authorize

  def mem
    @previous_memory = GetProcessMem.new.mb.round

    @some_array ||= []
    (performance_param[:mem_limit] || 100).to_i.times do
      @some_array << 'a' * 1024
      sleep(0.1)
    end
  end

  def cpu
    tasktimer = Time.now

    (performance_param[:cpu_core] || 2).to_i.times do
      Process.fork do
        (performance_param[:cpu_limit] || 10).to_i.times do |i|
          100_000.downto(1) do |j|
            Math.sqrt(j) * i / 0.2
          end
        end
      end
    end

    @time_elapsed = Time.now - tasktimer
  end

  private

  def authorize
    is_authorized = ActiveSupport::SecurityUtils.secure_compare(performance_param[:secret].to_s, ENV['PERFORMANCE_SECRET'].to_s)
    return head :forbidden unless is_authorized
  end

  def performance_param
    params.permit(
      :secret,
      :mem_limit,
      :mem_reset,
      :cpu_core,
      :cpu_limit
    )
  end
end
