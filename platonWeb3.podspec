
Pod::Spec.new do |s|

  s.name         = "platonWeb3"
  
  s.version      = "0.3.0"

  s.summary      = "platonWeb3 SDK is a Swift development kit for PlatON public chain provided by PlatON for iOS developers."

  s.description  = "platonWeb3 SDK is a Swift development kit for PlatON public chain provided by PlatON for iOS developers."

  s.homepage     = "https://github.com/PlatONnetwork/client-sdk-ios"
  
  s.license      = "MIT"
  
  s.author = { "support" => "support@platon.network" }

  s.source       = { :git => "https://github.com/PlatONnetwork/client-sdk-ios", :tag => "#{s.version}" }

  s.source_files = "source/**/*.swift"

  s.platform     = :ios, "9.0"

  s.dependency 'BigInt'
  s.dependency 'CryptoSwift'
  s.dependency 'secp256k1.swift'
  s.dependency 'Localize-Swift'

  s.pod_target_xcconfig = { 'SWIFT_OPTIMIZATION_LEVEL' => '-Owholemodule' }


end
