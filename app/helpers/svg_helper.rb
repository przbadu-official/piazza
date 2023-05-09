# frozen_string_literal: true

module SvgHelper
  def svg(svg_name, **attributes)
    svg_markup = render(file: Rails.root.join("app/views/shared/svg/#{svg_name}.svg"))

    xml = Nokogiri::XML(svg_markup)
    attributes&.each do |key, value|
      xml.root.set_attribute(key, value)
    end

    # rubocop:disable Rails/OutputSafety
    xml.root.to_xml.html_safe
    # rubocop:enable Rails/OutputSafety
  end
end
