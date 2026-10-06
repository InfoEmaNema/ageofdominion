# Bundles the source modules so the game also runs from file:// URLs.
modules = %w[hex data world combat state game tech save render audio ui main]
out = +"(function(){\nconst __modules = {};\n"
modules.each do |name|
  path = File.join(__dir__, 'js', "#{name}.js")
  source = File.read(path)
  source.gsub!(/import\s*\{([^}]+)\}\s*from\s*['"]\.\/([^'"]+)['"];?/) do
    names = Regexp.last_match(1).strip
    dependency = File.basename(Regexp.last_match(2), '.js')
    "const { #{names} } = __modules.#{dependency};"
  end
  exports = source.scan(/\bexport\s+(?:function|const|let|class)\s+([\w$]+)/).flatten
  source.scan(/\bexport\s*\{([^}]+)\};?/m).flatten.each do |list|
    exports.concat(list.split(',').map { |item| item.strip.split(/\s+as\s+/).last })
  end
  source.gsub!(/\bexport\s+(?=(?:function|const|let|class)\b)/, '')
  source.gsub!(/\bexport\s*\{[^}]*\};?/m, '')
  out << "__modules.#{name} = (function(){\n#{source}\nreturn {#{exports.uniq.join(',')}};\n})();\n"
end
out << "})();\n"
File.write(File.join(__dir__, 'js', 'offline.bundle.js'), out)
puts "Built js/offline.bundle.js from #{modules.length} source modules."
