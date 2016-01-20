Pod::Spec.new do |spec|
  spec.name = "Every.swift"
  spec.version = "1.0.0"
  spec.summary = "An Swift wrapper for NSTimer"
  spec.homepage = "https://github.com/samhann/Every.swift"
  spec.license = { type: 'MIT', file: 'LICENSE' }
  spec.authors = { "Samhan" => 'pickledbrains+pods@gmail.com' }
  spec.social_media_url = "http://twitter.com/samhanknr"

  spec.platform = :ios, "8.0"
  spec.requires_arc = true
  spec.source = { git: "https://github.com/samhann/Every.swift.git", tag: "v#{spec.version}", submodules: true }
  spec.source_files = "src/**/*.{h,swift}"
end