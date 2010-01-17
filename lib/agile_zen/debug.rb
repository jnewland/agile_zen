module ActiveResource
  class Connection
    private
    # Override request to include headers if debug mode is turned on
    def request(method, path, *arguments)
      logger.info "#{method.to_s.upcase} #{site.scheme}://#{site.host}:#{site.port}#{path}" if logger
      logger.info arguments.inspect if logger
      result = nil
      ms = Benchmark.ms { result = http.send(method, path, *arguments) }
      logger.info "--> %d %s (%d %.0fms)" % [result.code, result.message, result.body ? result.body.length : 0, ms] if logger
      handle_response(result)
    rescue Timeout::Error => e
      raise TimeoutError.new(e.message)
    rescue OpenSSL::SSL::SSLError => e
      raise SSLError.new(e.message)
    end
  end
end

ActiveResource::Formats::AgileZenXmlFormat.logger = AgileZen::Base.logger