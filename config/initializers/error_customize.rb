ActionView::Base.field_error_proc = proc do |html_tag, instance|
  if instance.is_a?(ActionView::Helpers::Tags::Label)
    html_tag
  else
    method_name = instance.instance_variable_get(:@method_name)
    errors = instance.object.errors[method_name]
    view = ActionView::Base.new
    field_tag = []
    field_tag << html_tag
    field_tag += errors.map do |error|
      view.content_tag(:div, class: "help-block") do
        "#{instance.object.class.human_attribute_name(method_name)}#{error}"
      end
    end
    view.content_tag(:span, class: "has-error") do
      view.safe_join(field_tag)
    end
  end
end
