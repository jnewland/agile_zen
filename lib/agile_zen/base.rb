class AgileZen::Base < ActiveResource::Base
  class << self

    # Set this to true if you'd like your API traffic sent over SSL
    def ssl=(ssl = false)
      self.site = 'https://agilezen.com/api/v1/' if ssl
    end

    # Turn on connection logging to STDOUT and monkey patch ActiveResource
    # to include headers when logging
    def debug=(debug = false)
      if debug
        require 'logger'
        self.logger = Logger.new(STDOUT)
        require 'agile_zen/debug'
      end
    end

    def key=(key)
      write_inheritable_attribute(:key, key)
    end

    def key
      AgileZen::Base.read_inheritable_attribute(:key)
    end

    def headers
      { 'X-Zen-ApiKey' => AgileZen::Base.key }
    end

    def all(*args)
      find(:all, *args)
    end

    # override to remove the period since AgileZen's API doesn't accept
    # extensions to specify content type
    def element_path(id, prefix_options = {}, query_options = nil)
      prefix_options, query_options = split_options(prefix_options) if query_options.nil?
      "#{prefix(prefix_options)}#{collection_name.singularize}/#{id}#{format.extension}#{query_string(query_options)}"
    end

    # override to remove the period since AgileZen's API doesn't accept
    # extensions to specify content type
    def collection_path(prefix_options = {}, query_options = nil)
      prefix_options, query_options = split_options(prefix_options) if query_options.nil?
      "#{prefix(prefix_options)}#{collection_name}#{format.extension}#{query_string(query_options)}"
    end
  end
end

AgileZen::Base.format = ActiveResource::Formats::AgileZenXmlFormat
AgileZen::Base.site = 'http://agilezen.com/api/v1/'