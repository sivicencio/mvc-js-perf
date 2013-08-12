json.array!(@frameworks) do |framework|
  json.extract! framework, :name, :url
  json.url framework_url(framework, format: :json)
end
