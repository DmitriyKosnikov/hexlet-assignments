# frozen_string_literal: true

# BEGIN
require 'date' 

module Model
  def self.included(base)
    base.extend(ClassMethods)
  end

  def initialize(attributes = {})
    self.class.attributes.each do |name, options|
      value = attributes.key?(name) ? attributes[name] : options[:default]
      converted_value = value.nil? ? nil : convert_type(value, options[:type])
      instance_variable_set("@#{name}", converted_value)
      instance_variable_set("@#{name}_set", attributes.key?(name))
    end
  end

  module ClassMethods
    def attribute(name, options = {})
      @attributes ||= {}
      @attributes[name] = options

      define_method(name) do
        value = instance_variable_get("@#{name}")
        value.nil? && !instance_variable_get("@#{name}_set") ? options[:default] : value
      end

      define_method("#{name}=") do |value|
        converted_value = value.nil? ? nil : convert_type(value, options[:type])
        instance_variable_set("@#{name}", converted_value)
        instance_variable_set("@#{name}_set", true)
      end
    end

    def attributes
      @attributes ||= {}
    end
  end

  private
  def convert_type(value, type)
    return nil if value.nil?

    case type
    when :integer
      value.to_i
    when :string
      value.to_s
    when :boolean
      value
    when :nil
      value
    when :datetime
      DateTime.parse(value)
    end
  end
end
# END
