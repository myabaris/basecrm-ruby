module BaseCrm
  class Contact < ApiClient::Resource::Base

    namespace "contact"

    prefix    "api/v1"

    always do
      endpoint "https://crm.futuresimple.com"
    end

    def initialize(attributes)
      super
      simplify_custom_fields
    end

    def simplify_custom_fields
      fields = self['custom_fields'] || {} 
      self['custom_fields'] = fields.inject({}) do |memo, field|
        name, value = field
        memo[name] = value['value']
        memo
      end
    end

    def payload
      hash = super
      hash.delete('tags_joined_by_comma')
      hash.delete('linkedin_display')
      hash
    end

  end
end
