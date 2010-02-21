require "libxml"
class Tablegrok
  include LibXML
  include XML::HTMLParser::Options
  OPTIONS = {:options => (RECOVER | NOERROR | NOWARNING | NONET)}
  def initialize(options = {})
  end
  
  def parse(thing)
    _parse case thing
    when XML::Document: thing
    when IO, File:      XML::HTMLParser.io(thing, OPTIONS).parse
    else;               XML::HTMLParser.string(thing.to_s, OPTIONS).parse
    end
  end
  
  def _parse(doc)
    doc.find("//table").map do |t|
      rows = t.find("tr").map{|e| e }
      header = rows.shift
      keys = header.find("td|th").map{|n| n.content }.map{|e| e }
      rows.map do |r|
        zipped = keys.zip(r.find("td|th").map{|n| n.content })
        zipped.inject({}) {|m, (k, v)| m[k] = v; m }
      end
    end
  end
end