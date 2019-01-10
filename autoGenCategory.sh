#pandoc -s --toc --toc-depth=5 web3.swift.md -o README.md && git add . && git commit -am "document" && git push origin 0.2.1

pod repo push JuzixSpecs platonWeb3.podspec --allow-warnings
