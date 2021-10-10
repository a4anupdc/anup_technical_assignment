module RestClientHelper
  def self.post(url, headers = {}, payload)
    resp = RestClient.post(url,payload,headers)
  end

  def self.put(url, headers = {}, payload)
    resp = RestClient.put(url,payload,headers)
  end

  def self.delete(url)
    resp = RestClient.delete(url)
  end

  def self.patch(url, headers = {}, payload)
    resp = RestClient.patch(url,payload,headers)
  end

  def self.get(url, headers = {})
    resp = RestClient.get(url,headers)
  end
end
