module ApplicationHelper
    def display_form_errors_for instance
        html = ''
        error_messages = ''
        if instance.errors.any?
          html << "<div class='alert alert-danger' role='alert'>"
          html << "<h5 class='alert-heading'>There was an error. Fix the #{ pluralize(instance.errors.count, 'error') } below before attempting to save.</h5>"
          html << "<ul>"
          
          instance.errors.full_messages.each do |msg|
            error_messages << "<li>#{ msg }</li>"
          end
          
          html << error_messages
          html << "</ul></div>"

          html.html_safe
        end
    end
end
