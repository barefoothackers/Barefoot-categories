Pod::Spec.new do |s|
  s.name         = "Barefoot-categories"
  s.version      = "0.0.1"
  s.summary      = "Useful categories"
  s.homepage     = "https://github.com/barefoothackers/Barefoot-categories"
  s.license      = "MIT"
  s.author       = "Barefoot Hackers"
  s.platform     = :ios, "5.0"
  s.source       = { :git => "https://github.com/barefoothackers/Barefoot-categories.git", :commit => "9a153341d467d5bc5fa0d99d3ab0440c327a708b" }
  s.source_files = "*.{h,m}"
  s.requires_arc = true
end
