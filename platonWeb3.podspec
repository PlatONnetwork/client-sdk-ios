
Pod::Spec.new do |s|

  s.name         = "platonWeb3"
  s.version      = "0.3.0.3"
  s.summary      = "PlatOn RPC SDK for iOS,A Web3 RPC tool to interact with PlatON node"

  s.description  = "add executeCode option for transaction in Data fileld"

  s.homepage     = "http://192.168.9.66/Juzix-Platon/web3j-ios"
  
  s.license      = "MIT"
  
  s.author = { "weixuening" => "weixuegg@gmail.com" }

  s.source       = { :git => "git@192.168.9.66:PlatON/client-sdk-ios.git", :tag => "#{s.version}" }
  ### open source configuration
  #s.source       = { :git => "https://github.com/PlatONnetwork/client-sdk-ios", :tag => "#{s.version}" }
  s.source_files = "source/**/*.swift"

  s.platform     = :ios, "9.0"

  s.dependency 'BigInt'
  s.dependency 'CryptoSwift'
  s.dependency 'secp256k1.swift'
  s.dependency 'Localize-Swift'

  s.pod_target_xcconfig = { 'SWIFT_OPTIMIZATION_LEVEL' => '-Owholemodule' }


end
