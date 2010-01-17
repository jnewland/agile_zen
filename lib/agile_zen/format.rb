module ActiveResource
  module Formats
    # Modify ActiveResource::Formats::XmlFormat for AgileZen as follows:
    #
    # * Remove the extension from all requests
    # * Handle AgileZen's paginated XML format
    module AgileZenXmlFormat
      extend self

      def extension
        ""
      end

      def mime_type
        "application/xml"
      end

      def encode(hash, options={})
        hash.to_xml(options)
      end

      def decode(xml)
        hash = Hash.from_xml(xml)
        @logger.info hash.inspect if @logger
        data = from_xml_data(hash)
        @logger.info data.inspect if @logger
        data
      end

      def logger=(logger)
        @logger = logger
      end

      private
        # Manipulate from_xml Hash, because xml_simple is not exactly what we
        # want for Active Resource.
        def from_xml_data(data)
          if data.is_a?(Hash) && data.keys.size == 1
            if data.values.first['items']
              data = data.values.first['items'].values.first
              data.is_a?(Hash) ? [data] : data
            else
              data.values.first
            end
          else
            data
          end
        end
    end
  end
end
