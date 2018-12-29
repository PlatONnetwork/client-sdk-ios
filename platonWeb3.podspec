
Pod::Spec.new do |s|

  s.name         = "platonWeb3"
  s.version      = "0.2.1.1"
  s.summary      = "PlatOn RPC SDK for iOS"

  s.description  = "A Web3 RPC tool to interact with PlatON node"

  s.homepage     = "http://192.168.9.66/Juzix-Platon/web3j-ios"
  
  s.license      = "MIT"
  
  s.author             = { "weixuening" => "weixuegg@gmail.com" }

  s.source       = { :git => "git@192.168.9.66:Juzix-Platon/web3j-ios.git", :branch => "#{s.version}" }
  s.source_files = "source/**/*.swift"

  s.platform     = :ios, "9.0"

  s.dependency 'BigInt'
  s.dependency 'CryptoSwift'
  s.dependency 'secp256k1.swift'
  s.dependency 'Localize-Swift'

  s.pod_target_xcconfig = { 'SWIFT_OPTIMIZATION_LEVEL' => '-Owholemodule' }


end
