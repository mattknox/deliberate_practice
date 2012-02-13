/*  before: try to get this done in minimal time and lines */
int strstr(char *orig_needle, char *orig_haystack) {
  char *haystack = orig_haystack, *needle = orig_needle;
  while(*haystack) {
    if (*needle == NULL) {
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
/* after: annoying that I had to do a 3-case comparison */

/* before: gonna do this one without a 3-case comparison  */
int strstr2(char *orig_needle, char *orig_haystack) {
  char *needle = orig_needle, *haystack = orig_haystack;
  while (*needle && *haystack) {
    if (*needle == *haystack) {
      haystack++;
      needle++;
    } else {
      haystack -= (needle - orig_needle);
      needle = orig_needle;
    }
  }
  return (*needle ? -1 : haystack - (needle - orig_needle));
}

int strstr3(char *needle, char *haystack) {
  int i = 0;
  while (*haystack && *needle) {
    if (*(haystack + i) == *(needle + i)) {
       i++
    } else {
      i = 0;
      haystack++;
    }
  }
  return (i > 0 ? i : -1)
}


int strstr4(char *needle, char *haystack) {
  int i = 0;
  while(*haystack) {
    if (*(needle+i) == NULL) {
      return i; //wrong.
    } else if (*(haystack+i) == *(needle+i)) {
      i++;
    } else {
      i = 0;
      haystack++
    }
  }
  return -1;
}
