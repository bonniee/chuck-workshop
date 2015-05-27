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


### Basic programming constructs

ChucK is a musical programming language. It also includes most of the "normal" programming language constructs.

This is mostly for reference.

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

Yeah, ChucK has classes. [Here are the docs](http://chuck.cs.princeton.edu/doc/language/class.html).

Example:

```
// classExample.ck
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


<audio controls>
  <source src="assets/sound/classExample.m4a" type="audio/mp4">
  Your browser does not support the audio tag.
</audio>



#### Concurrency

Concurrency in ChucK works via _sporking_. We'll cover this later.

#### Helpful functions

The `Std` [library](chuck.cs.princeton.edu/doc/program/stdlib.html) contains some helpful functions. Also, `Math`!

- `Std.mtof(int midi)` takes a MIDI value (int) and converts it to a frequency in Hz.
- `Math.random2(int min, int max)` is good for adding some variation to your pieces.


## Volume

The perceived __volume__ of a sound is determined by the __amplitude__ of the wave.

We can change amplitude using the `gain` method of any sound-generator (called a `UGen` in Chuck). Like so:

```
SinOsc s => dac;
s.gain(1); // Full volume
1::second => now;
s.gain(0.5); // Half volume
1::second => now;
```

We can also change gain more rapidly:

```
// changeAmplitude.ck
SinOsc s => dac;
s.freq(Std.mtof(70));
s.gain(0);

for (0=> int i; i < 100; i++)
{
  s.gain(i * .01);
  10::ms => now;
}
```


<audio controls>
  <source src="assets/sound/changeAmplitude.m4a" type="audio/mp4">
  Your browser does not support the audio tag.
</audio>


## Pitch and Frequency

The perceived __loudness__ of a tone is determined by the __amplitude__ of the wave, and the perceived __pitch__ is determined by the frequency of the wave.

Let's make two beeps now, and try varying their pitches and volume.


## Types of waves

Remember I talked about sine, square, triangle, and saw waves? Yeah.

## Programming time!

Hey! You've covered enough at this point that you should be able to try your hand at **composing** (or programming, if you prefer...) some music.

Here are some ideas:

- Try to synthesize an organ-like noise.
- Play Mary Had a Little Lamb.
- Make some weird computer-y noises.
- I dunno, have fun!

## Combining Waves: LFOs

```
// lfo.ck
SinOsc s => dac;
SinOsc lfo => blackhole;

440 => s.freq;
5 => lfo.freq;
while (true)
{
  20::ms => now;
  (lfo.last() * 10) + 440 => s.freq;
}
```

// tODO add sound file

## Combining Waves: Adding Overtones


## Envelopes

## The Noise Ugen

## ADSR and Characteristic Sounds


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



 