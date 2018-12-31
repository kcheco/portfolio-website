class UrlValidator < ActiveModel::EachValidator
  def self.http_compliant?(value)
    pattern = '\A(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z'
    regexp = Regexp.new(pattern)
    uri = URI.parse(value)
    regexp.match?(uri.to_s)
  rescue URI::InvalidURIError
    false
  end

  def validate_each(record, attribute, value)
    unless value.present? && self.class.http_compliant?(value)
      record.errors.add(attribute, "is not a valid HTTP URL")
    end
  end
end
