module Admin
  module EventsHelper
    BG_STATUS_CLASS = {
      Event::PLANNED      => 'olive',
      Event::REGISTRATION => 'green',
      Event::CONFIRMATION => 'teal',
      Event::LIVE         => 'red',
      Event::PASSED       => 'grey'
    }

    def admin_visit_requests_link(event, options = { class: 'item' })
      return unless event.persisted?

      link_to icon(:users, t('visit_requests.plural')),
        admin_event_visit_requests_path(event), options
    end

    def event_status_label(event)
      content_tag :span, event.status,
        class: ['ui label', BG_STATUS_CLASS[event.status.to_sym]]
    end

    # def event_visitors_optimized_stat(event)
    #   used_visit_requests_count      = event.used_visit_requests.length
    #   confirmed_visit_requests_count = event.confirmed_visit_requests.length
    #   approved_visit_requests_count  = event.approved_visit_requests.length
    #   pending_visit_requests_count   = event.pending_visit_requests.length
    #
    #   sum_pending_count   = pending_visit_requests_count + approved_visit_requests_count + confirmed_visit_requests_count + used_visit_requests_count
    #   sum_approved_count  = approved_visit_requests_count + confirmed_visit_requests_count + used_visit_requests_count
    #   sum_confirmed_count = confirmed_visit_requests_count + used_visit_requests_count
    #   sum_used_count      = used_visit_requests_count
    #
    #   {
    #     Event::REGISTRATION => {
    #       real_count: pending_visit_requests_count,
    #       sum_count:  sum_pending_count,
    #       progress:   (sum_pending_count.to_f / event.limit_total  * 100).round,
    #       max:        event.limit_total
    #     },
    #     Event::CONFIRMATION => {
    #       real_count: approved_visit_requests_count,
    #       sum_count:  sum_approved_count,
    #       progress:   (sum_pending_count.to_f / event.limit_total  * 100).round
    #     },
    #     Event::LIVE => {
    #       real_count: confirmed_visit_requests_count,
    #       sum_count:  sum_confirmed_count
    #     },
    #     Event::PASSED => {
    #       real_count: used_visit_requests_count,
    #       sum_count:  sum_used_count
    #     }
    #   }

      # {
      #   t('events.index.visitors.requested') => event.pending_visit_requests.length,
      #   t('events.index.visitors.approved')  => event.approved_visit_requests.length,
      #   t('events.index.visitors.confirmed') => event.confirmed_visit_requests.length,
      #   t('events.index.visitors.visited')   => event.used_visit_requests.length,
      # }
    # end

    def event_verified_user_data(event)
      verified = event.verified_visitors.length
      newbies  = event.newbie_visitors.length

      "#{verified} / #{newbies}"
    end

    def event_status_count_max_data(count, max)
      "#{count} / #{max}"
    end

    def send_confirmation_emails_link(event)
      return unless event.confirmation?

      link_to t('events.send_confirmations'),
        send_confirmations_admin_event_visit_requests_path(event),
        method: :post, class: 'ui button red',
        data: { confirm: t('phrases.confirm') }
    end
  end
end
