---
name: copy
description: Write or rewrite the words in a product, page, doc or message so they read as a person wrote them. Use for headlines, UI strings, landing pages, READMEs, release notes, emails, and any text a reader will judge.
---

# copy

`rules/common/writing.md` is the law. This skill is the procedure.

## Steps
1. **Who reads it, in what state.** A dev in a terminal at 2am, a buyer skimming on a phone, a teammate reviewing a PR. One sentence. Everything else follows from it.
2. **What must they know or do.** One line. If two, split the text.
3. **Draft short.** Half the length you think. Headlines under eight words. Body paragraphs under sixty.
4. **Slop pass.** Run the banned lists against every line. Replace, do not soften. Then read it aloud once; anything you would not say to a colleague goes.
5. **Specificity pass.** Every adjective either becomes a number or a named thing, or is cut. "Fast" becomes "under 100ms" or nothing.
6. **Rhythm pass.** Sentence lengths should vary by eye. Two long in a row, cut one. Three short in a row, join two.
7. **Localise** if the product does. Every string in every locale, same PR. Never machine-translate the source language's idioms literally.

## Templates that hold up
- Landing hero: `<what it does, plain> for <who>.` Then one line with the specific proof. Then a verb button.
- Feature block: a noun heading, one sentence of what, one of why it matters to the reader, optional one of how.
- Error: `<what happened>. <what to do>.` "Payment declined. Try another card or contact your bank."
- Release note: `type(scope): what changed, in the reader's terms`. No "we're excited".
- README opener: what it is, who it is for, the one command to try it. Under five lines before the first code block.

## Refuse
- Testimonials or reviews you did not receive.
- Stats without a source you can name.
- Urgency that is not real ("only 3 left").

## Not this skill
- Choosing the visual direction the words sit in: `design`.
- Docs structure and repo docs: `implement`, with this skill for the prose.
