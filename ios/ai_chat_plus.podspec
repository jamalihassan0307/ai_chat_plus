#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
#
Pod::Spec.new do |s|
  s.name             = 'ai_chat_plus'
  s.version          = '1.0.6'
  s.summary          = 'A Flutter package for AI chat functionality'
  s.description      = <<-DESC
A Flutter package that provides AI chat functionality with enhanced features including OpenAI, Google Gemini, and Claude AI integrations.
                       DESC
  s.homepage         = 'https://github.com/jamalihassan0307/ai_chat_plus'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end 