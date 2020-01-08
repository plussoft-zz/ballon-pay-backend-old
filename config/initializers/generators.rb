Rails.application.config.generators do |g|
  g.orm :active_record, primary_key_type: :uuid

  hacker = Module.new do
    def options_for_migration
      ar = Rails.application.config.generators.active_record
      return super unless %i[belongs_to references].include?(type) && \
                          ar[:primary_key_type] == :uuid

      { type: :uuid }.merge(super)
    end
  end
  require 'rails/generators/generated_attribute'
  Rails::Generators::GeneratedAttribute.prepend hacker
end