int strstr(char *orig_needle, char *orig_haystack) {
  char *haystack = orig_haystack, *needle = orig_needle;
  while(*haystack) {
    if (*needle) {
      return haystack - orig_haystack;
    } else if (*haystack == *needle) {
      haystack++;
      needle++;
    } else {
      haystack -= (needle - orig_needle);
      needle = orig_needle;
    }
  }
  return -1;
}
