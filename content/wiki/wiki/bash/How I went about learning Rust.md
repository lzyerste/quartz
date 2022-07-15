---
title: "How I went about learning Rust"
---

https://eli.thegreenplace.net/2022/how-i-went-about-learning-rust/

Rust has been on my radar for a [long time now](https://eli.thegreenplace.net/2015/another-look-at-my-programming-language-arsenal/), and about a year ago I finally began allocating some time every week to learning it.

In this post I'll provide details on the learning path I've followed for Rust, in the hope that this may prove useful for others. You'll note that this isn't exactly a "Learn X in 24 hours" kind of journey, as it stretches over a long time period and covers lots of different materials. YMMV.

This learning journey alternates consuming information (mostly books) with coding activities (some guided by books, some not). In my experience, both are critical for really learning a language or any other tool deeply, and the combination of the two is powerful.

## Consuming information

These are the Rust-specific books I've read, roughly in chronological order. There are additional books in the "writing code" section, but those are not Rust-specific.

**Programming Rust** ([link to review](https://eli.thegreenplace.net/2021/summary-of-reading-july-september-2021/)) is the first book I read for an initial introduction to the language.

**The Rust Programming Language** - I haven't read this one cover to cover, but have skimmed major parts of it, implementing the projects it lists. I've also used it a bunch as a reference since it usually comes up high in Google rankings; it's a better reference than **Programming Rust**, IMHO.

**Rust in Action** ([link to review](https://eli.thegreenplace.net/2022/summary-of-reading-january-march-2022/)).

**Rust for Rustaceans** ([link to review](https://eli.thegreenplace.net/2022/summary-of-reading-april-june-2022/)).

In addition to these books, I've watched a few of John Gjengset's videos on YouTube. These are very interesting, and I'll probably watch more to learn about specific advanced concepts of Rust, as needed.

Finally, over this year I've read a bunch of blog posts about Rust, mostly stuff that made it to the front pages of HN or r/rust from time to time.

## Writing code

[rustlings](https://github.com/rust-lang/rustlings) - small exercises for reading and writing snippets of Rust code. Nice concept, though not very comprehensive. It's still quite useful when just getting started.

[Advent of Code](https://adventofcode.com/) - I _love_ AOC, and the 2021 edition was a great opportunity to practice some Rust. I've implemented the solutions for days 1-18 in Rust, for a total of ~2 KLOC. Solving AOC problems is a terrific way to learn and practice programming languages. I'm very likely to tackle AOC 2022 in Rust again, to keep my skills sharp.

The **Ray Tracer Challenge** book ([link to review](https://eli.thegreenplace.net/2021/summary-of-reading-october-december-2021/)). This book is language agnostic, and I picked Rust to implement a simple ray tracer. Another great way to practice a new language! Almost 4 KLOC for this one.

**Crafting Interpreters** ([link to review](https://eli.thegreenplace.net/2022/book-review-crafting-interpreters-by-robert-nystrom/)). Reimplemented the majority of the _clox_ compiler and VM in Rust, ~2 KLOC.

In addition to these, I've done quite a bit of experimentation, writing code to explore various areas of Rust. Some of this was mentioned in [blog posts](https://eli.thegreenplace.net/tag/rust), but most wasn't. I estimate there's a total of ~6 KLOC of Rust there.

Overall, over these past months I've written about 14 KLOC of Rust in the process of learning and practicing the language.

## What's next

I wouldn't call myself a Rust expert, but over this last year I believe I've developed a good understanding and intuition for the language, to the extent that I would feel confident using it for a production project.

Overall, I like Rust and I'm happy to have added it to my toolbox. It has issues, and I certainly have opinions about it, but that will have to wait for a separate post :-)