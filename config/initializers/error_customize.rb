ActionView::Base.field_error_proc = proc do |html_tag, instance|
  if instance.is_a?(ActionView::Helpers::Tags::Label)
    html_tag.html_safe
  else
    method_name = instance.instance_variable_get(:@method_name)
    errors = instance.object.errors[method_name]
    html = <<~EOM
      <div class="has-error">
        #{html_tag}
        <span class="help-block">
          #{I18n.t("activerecord.attributes.#{instance.object.class.name.underscore}.#{method_name}")}
          #{errors.first}
        </span>
      </div>
    EOM
    html.html_safe
  end
end
