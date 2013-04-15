# ClientSideValidations Initializer

# Uncomment to disable uniqueness validator, possible security issue
# ClientSideValidations::Config.disabled_validators = [:uniqueness]

# Uncomment to validate number format with current I18n locale
# ClientSideValidations::Config.number_format_with_locale = true

# Uncomment the following block if you want each input field to have the validation messages attached.
# ClientSideValidations Initializer
 
require 'client_side_validations/simple_form' if defined?(::SimpleForm)
require 'client_side_validations/formtastic'  if defined?(::Formtastic)
# Uncomment the following block if you want each input field to have the
# validation messages attached.
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  unless html_tag =~ /^<label/
    %{</pre>
<div class="field_with_errors">#{html_tag}<label class="message" for="#{instance.send(:tag_id)}">#{instance.error_message.first}</label></div>
<pre>}.html_safe
  else
    %{</pre>
<div class="field_with_errors">#{html_tag}</div>
<pre>}.html_safe
  end
end
