
$version = "0.13.3"

Pod::Spec.new do |s|

  s.name         = "platonWeb3" 

  s.version      = $version

  s.summary      = "platonWeb3 SDK is a Swift development kit for PlatON public chain provided by PlatON for iOS developers."

  s.description  = "platonWeb3 SDK is a Swift development kit for PlatON public chain provided by PlatON for iOS developers."

  s.homepage     = "https://github.com/PlatONnetwork/client-sdk-ios"
  
  s.license      = "MIT"
  
  s.author       = { "chendai" => "daniel@platon.network" }

  s.source       = { :git => "https://github.com/PlatONnetwork/client-sdk-ios.git", :tag => $version }

  s.source_files = "source/**/*.swift"

  s.platform     = :ios, "11.0"

  s.dependency 'BigInt', '~> 5.2.0'
  s.dependency 'CryptoSwift', '~> 1.4.3'
  s.dependency 'secp256k1.swift', '~> 0.1.4'
  s.swift_versions = ['5.0', '5.1', '5.2']

  s.pod_target_xcconfig = { 'c' => '-Owholemodule' }

end

