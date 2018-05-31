Pod::Spec.new do |s|
  s.name = 'SASClient'
  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.11'
  s.version = '1.0.0'
  s.source = { :git => 'git@github.com:swagger-api/swagger-mustache.git', :tag => 'v1.0.0' }
  s.authors = 'Swagger Codegen'
  s.license = 'Proprietary'
  s.homepage = 'http://bluberrie.io/SAS'
  s.summary = 'SAS client'
  s.source_files = 'SASClient/Classes/Swaggers/**/*.swift'
  s.dependency 'Alamofire', '~> 4.0'
end
