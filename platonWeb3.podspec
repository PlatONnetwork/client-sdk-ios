
Pod::Spec.new do |s|

  s.name         = "platonWeb3"

  s.version      = "0.7.4"

  s.summary      = "platonWeb3 SDK is a Swift development kit for PlatON public chain provided by PlatON for iOS developers."

  s.description  = "platonWeb3 SDK is a Swift development kit for PlatON public chain provided by PlatON for iOS developers."

  s.homepage     = "https://github.com/PlatONnetwork/client-sdk-ios"
  
  s.license      = "MIT"
  
  s.author = { "admin" => "support@platon.network" }

  s.source       = { :git => "https://github.com/AngryBaby/client-sdk-ios.git", :commit => "b85f4f6" }

  s.source_files = "source/**/*.swift"

  s.platform     = :ios, "9.0"

  s.dependency 'BigInt', '~> 4.0'
  s.dependency 'CryptoSwift', '~> 0.8'
  s.dependency 'secp256k1.swift', '~> 0.1'
  s.dependency 'Localize-Swift', '~> 2.0'

  s.pod_target_xcconfig = { 'SWIFT_OPTIMIZATION_LEVEL' => '-Owholemodule' }

end
