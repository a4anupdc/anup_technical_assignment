# frozen_string_literal: true

# Module with all helper methods needed for REST operations.
module RestClientHelper
  def self.post(url, headers = {}, payload)
    RestClient.post(url, payload, headers)
  end

  def self.put(url, headers = {}, payload)
    RestClient.put(url, payload, headers)
  end

  def self.delete(url)
    RestClient.delete(url)
  end

  def self.patch(url, headers = {}, payload)
    RestClient.patch(url, payload, headers)
  end

  def self.get(url, headers = {})
    RestClient.get(url, headers)
  end
end
