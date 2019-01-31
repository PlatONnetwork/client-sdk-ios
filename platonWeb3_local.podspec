
Pod::Spec.new do |s|

  s.name         = "platonWeb3_local"

  s.version      = "0.3.0.14"

  s.summary      = "platonWeb3 SDK is a Swift development kit for PlatON public chain provided by PlatON for iOS developers."

  s.description  = "platonWeb3 SDK is a Swift development kit for PlatON public chain provided by PlatON for iOS developers."

  s.homepage     = "http://192.168.9.66/PlatON/client-sdk-ios"
  
  s.license      = "MIT"
  
  s.author = { "admin" => "support@platon.network" }

  s.source       = { :git => "git@192.168.9.66:PlatON/client-sdk-ios.git", :tag => "#{s.version}" }

  s.source_files = "source/**/*.swift"

  s.platform     = :ios, "9.0"

  s.dependency 'BigInt'
  s.dependency 'CryptoSwift'
  s.dependency 'secp256k1.swift'
  s.dependency 'Localize-Swift'

  s.pod_target_xcconfig = { 'SWIFT_OPTIMIZATION_LEVEL' => '-Owholemodule' }


end
