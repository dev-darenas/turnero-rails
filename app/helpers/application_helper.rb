module ApplicationHelper
  def wait_time(turn)
    return ((Time.now - turn.created_at)/60).round if turn.pending?
    " - "
  end
end
