module ApplicationHelper
  def custom_bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      text = "
        <script>
          toastr.options = {
              'progressBar': true,
              'positionClass': 'toast-bottom-left',
              'preventDuplicates': true,
              'showDuration': '300',
              'hideDuration': '1000',
              'timeOut': '5000',
              'extendedTimeOut': '1000',
              'showEasing': 'swing',
              'hideEasing': 'linear',
              'showMethod': 'fadeIn',
              'hideMethod': 'fadeOut'
          }
          toastr.#{flash_class(type)}(\"#{message}\");
        </script>
      "
      flash_messages << text.html_safe if message
    end

    flash_messages.join("\n").html_safe
  end

  def flash_class(type)
    case type
      when 'success' then 'success'
      when 'notice' then 'success'
      when 'error' then 'error'
      when 'alert' then 'warning'
    end
  end
end
