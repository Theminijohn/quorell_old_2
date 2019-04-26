module ApplicationHelper
  def custom_bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      case type
      when 'notice'
        toastr_type = 'success'
      when 'alert'
        toastr_type = 'error'
      else
        toastr_type = 'info'
      end

      text = "<script>toastr.#{toastr_type}('#{message}');</script>"
      flash_messages << text.html_safe if message
    end

    flash_messages.join("\n").html_safe
  end
end
