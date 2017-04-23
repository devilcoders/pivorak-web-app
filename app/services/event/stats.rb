class Event
  class Stats < ApplicationService
    attr_reader :real_count, :sum_count, :progress, :max

    def initialize(event, status = nil)
      @event  = event
      @status = status || event.status.to_sym
    end

    def call
      @used_visit_requests_count      = event.used_visit_requests.length
      @confirmed_visit_requests_count = event.confirmed_visit_requests.length
      @approved_visit_requests_count  = event.approved_visit_requests.length
      @pending_visit_requests_count   = event.pending_visit_requests.length

      @sum_pending_count   = pending_visit_requests_count + approved_visit_requests_count + confirmed_visit_requests_count + used_visit_requests_count
      @sum_approved_count  = approved_visit_requests_count + confirmed_visit_requests_count + used_visit_requests_count
      @sum_confirmed_count = confirmed_visit_requests_count + used_visit_requests_count
      @sum_used_count      = used_visit_requests_coun
    end

    private

    attr_reader :event, :status
  end
end


# {
#   Event::REGISTRATION => {
#     real_count: pending_visit_requests_count,
#     sum_count:  sum_pending_count,
#     progress:   (sum_pending_count.to_f / event.limit_total  * 100).round,
#     max:        event.limit_total
#   },
#   Event::CONFIRMATION => {
#     real_count: approved_visit_requests_count,
#     sum_count:  sum_approved_count,
#     progress:   (sum_pending_count.to_f / event.limit_total  * 100).round
#   },
#   Event::LIVE => {
#     real_count: confirmed_visit_requests_count,
#     sum_count:  sum_confirmed_count
#   },
#   Event::PASSED => {
#     real_count: used_visit_requests_count,
#     sum_count:  sum_used_count
#   }
# }
