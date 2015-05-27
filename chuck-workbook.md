#Student Workbook: Introduction to Musical Programming using ChucK
## Joy of Coding Workshop by Bonnie Eisenman

## Table of Contents

This page is available at [http://blog.bonnieeisenman.com/chuck-workshop/](http://blog.bonnieeisenman.com/chuck-workshop/). The github repo is [bonniee/chuck-workshop](https://github.com/bonniee/chuck-workshop).

- [Introduction to Chuck: Syntax and Setup](#intro)
  - What is ChucK?
  - Hello World / Beep!
  - Basic Programming Constructs
- Amplitude
- Pitch
- Vibrato and FM Modulation
- Working with Existing UGens and Instruments
- Some Hardware Examples



## <a name="intro"></a>ChucK Intro: Syntax and Setup

### What is ChucK?
ChucK is a musical programming language developed at Princeton. The homepage is here: [http://chuck.cs.princeton.edu](http://chuck.cs.princeton.edu)

Before we begin:

- [Install ChucK](chuck.cs.princeton.edu/release/).
- Decide if you want to use the IDE (MiniAudicle) or the command line.
- Turn your volume down to '0'. Remember that "bugs" in musical programs can produce nasty noises!

### Basic programming constructs

ChucK is a musical programming language. It also includes most of the "normal" programming language constructs.

This is mostly for reference. Skip ahead to [Hello, World](#helloworld) and refer back here if it's useful.

#### Printing

```
<<< "Hi!"" >>>;
```

#### Variables

```
42 => int answer;
525600::minute => dur measureAYear;
6.28 => float tau;
```
[More on types.](http://chuck.cs.princeton.edu/doc/language/type.html)


#### Arrays

[Docs.](http://chuck.cs.princeton.edu/doc/language/array.html)

```
int foo[10];
[55, 57, 59, 55] @=> int notes[];
```

ChucK also support associative and multidimensional arrays.

#### Loops

ChucK supports `for` and `while`.

```
for (0 => int i; i < 10; i++)
{
  <<< "loops are cool I guess" >>>;
}
```

```
while (true)
{
  <<< "This can be useful for looping audio." >>>;
  1::second => now; // Wait 1 second
}
```

#### Functions

```
fun void hey(string s )
{
  <<< "Hello, ", s, "!" >>>;
}
hey("everyboy");
```

#### Classes

Yeah, ChucK has classes. [Here's my example](https://github.com/bonniee/chuck-workshop/blob/master/code/classExample.ck), and [here are the docs](http://chuck.cs.princeton.edu/doc/language/class.html).

Example:

```
class Note
{
  // pre-constructor, run every time an instance is created
  SinOsc o => Envelope e => dac;
  250::ms => dur tempo;

  fun void quarter(int m)
  {
    Std.mtof(m) => o.freq;
    e.keyOn();
    tempo => now;
    e.keyOff();
  }
}

Note n;
n.quarter(55);
n.quarter(57);
n.quarter(59);
n.quarter(55);
100::ms => now;
```

#### Concurrency

Concurrency in ChucK works via _sporking_. We'll cover this later.


### Hello, World (or, Beep!)

The equivalent of "hello world" for musical programs is making them beep! In ChucK, scripts or programs are called 

```
# hello.ck
SinOsc osc => dac;
1::second => now;
```

<audio controls>
  <source src="assets/sound/hello.m4a" type="audio/mp4">
  Your browser does not support the audio tag.
</audio>



The first line creates a _sine wave_ and _chucks_ it to the _dac_. Whoa, new terminology!

- Instead of the assignment operator, `=`, which you might see in other languages, ChucK uses the "chuck" operator, or `=>`.
- _dac_ is shorthand for your audio output (e.g. speakers or headphones). Similarly, _adc_ refers to your microphone. Docs: [http://chuck.cs.princeton.edu/doc/program/ugen_full.html#dac](http://chuck.cs.princeton.edu/doc/program/ugen_full.html#dac)
- A SinOsc is a _unit generator_ that produces sine waves. Docs: [http://chuck.cs.princeton.edu/doc/program/ugen_full.html#sinosc](http://chuck.cs.princeton.edu/doc/program/ugen_full.html#sinosc)

A sine wave looks like this:

![Sine wave](assets/img/sin.png)

We perceive a sine wave as a tone, so sending a sine wave to the dac creates an audible noise.

The first line alone won't do anything, however, because the program will immediately terminate. The second line causes the program to wait for one second. `1::second` creates a _duration_ object; chucking it into _now_ causes the program to wait.

### Volume

The perceived __volume__ of a sound is determined by the __amplitude__ of the wave.

### Pitch and Volume

The perceived __loudness__ of a tone is determined by the __amplitude__ of the wave, and the perceived __pitch__ is determined by the frequency of the wave.

Let's make two beeps now, and try varying their pitches and volume.


```
# hello2.ck
SinOsc osc => Gain g => dac;

.5 => g.gain;
440 => osc.freq;
500::ms => now;

220 => osc.freq;
.25 => g.gain;
1000::ms => now;
```

<audio controls>
  <source src="assets/sound/hello2.m4a" type="audio/mp4">
  Your browser does not support the audio tag.
</audio>

New things of note:

- ChucK syntax is a little backwards when it comes to assignment, compared with other programming languages. It's `440 => osc.freq`, not `osc.freq = 440`.
- You can chain `=>` operators together! This syntax is inspired by the physical legacy of electronic music, when you might be literally chaining together multiple objects using wires.
- A `Gain` is a unit generator that controls volume. Docs: [http://chuck.cs.princeton.edu/doc/program/ugen_full.html#gain](http://chuck.cs.princeton.edu/doc/program/ugen_full.html#gain)
- We're now using milliseconds, or `ms`, instead of seconds. You can also use `minute`, `hour`, `day`, or even `week`. 

Changing the frequency of a wave can dramatically impact how we perceive it. If you lower the pitch, you will hear a __beat__ instead of a __tone__. You may need headphones or good-quality speakers, not normal laptop speakers, to hear this.


```
# beat.ck
SinOsc osc => dac;
40 => osc.freq;
2::second => now;
```

<audio controls>
  <source src="assets/sound/beat.m4a" type="audio/mp4">
  Your browser does not support the audio tag.
</audio>

What's the difference between 

## planning

- demonstrate beats
- demonstrate changing the volume
- do a beat
- overlay a melody to demonstrate sporking



 