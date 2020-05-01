# tokenize "Hey @lethain, did you know about a #typo on page 24 of your book?"
# should return:
{ raw: "Hey @lethain, did you know about a #typo on page 24 of your book?",
  spans: [
    { kind: "mention", text: "@lethain", start: 4, length: 8},
    { kind: "hashtag", text: "#typo", start: 35, length: 5}
  ]
}

module Tokenizer
  DELIMITERS = {
    "@": "mention",
    "#": "hashtag",
  }

  SPLITTER = /([#@]\w+)/ # TODO: validations on hashtag or mention length?

  def self.tokenize(input)
    spans = []
    offset = 0
    input.split(SPLITTER).each do |s|
      spans << { kind: s[0].to_sym, text: s, start: offset, length: s.length } if s.match(SPLITTER)
      offset += s.length
    end
    {raw: input, spans: spans}
  end
end
