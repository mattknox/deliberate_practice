# tokenize "Hey @lethain, did you know about a #typo on page 24 of your book?"
# should return:
{ raw: "Hey @lethain, did you know about a #typo on page 24 of your book?",
  spans: [
    { kind: "mention", text: "@lethain", start: 4, length: 8},
    { kind: "hashtag", text: "#typo", start: 35, length: 5}
  ]
}
