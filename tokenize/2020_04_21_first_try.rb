# tokenize "Hey @lethain, did you know about a #typo on page 24 of your book?"
# should return:
{ raw: "Hey @lethain, did you know about a #typo on page 24 of your book?",
  spans: [
    { kind: "mention", text: "@lethain", start: 4, length: 8},
    { kind: "hashtag", text: "#typo", start: 35, length: 5}
  ]
}

def tokenize(raw)
  kind_map = {"@" => "mention", "#" => "hashtag"}
  offset = 0
  spans = []
  raw.split(/([@#]\w+)/).each do |s|
    if s.match(/^[@#]\w+/)
      spans << { start: offset, length: s.size, text: s, kind: kind_map[s[0]]}
    end
    offset += s.size
  end
  { raw: raw,
    spans: spans
  }
end
