
Pod::Spec.new do |s|

  s.name         = "platonWeb3Local"

  s.version      = "develop"

  s.summary      = "platonWeb3 SDK is a Swift development kit for PlatON public chain provided by PlatON for iOS developers."

  s.description  = "platonWeb3 SDK is a Swift development kit for PlatON public chain provided by PlatON for iOS developers."

  s.homepage     = "https://github.com/PlatONnetwork/client-sdk-ios"
  
  s.license      = "MIT"
  
  s.author = { "admin" => "support@platon.network" }

  s.source       = { :git => "git@192.168.9.66:PlatON/client-sdk-ios.git", :branch => "#{s.version}" }

  s.source_files = "source/**/*.swift"

  s.platform     = :ios, "9.0"

  s.dependency 'BigInt'
  s.dependency 'CryptoSwift'
  s.dependency 'secp256k1.swift'
  s.dependency 'Localize-Swift'

  s.pod_target_xcconfig = { 'SWIFT_OPTIMIZATION_LEVEL' => '-Owholemodule' }


end
