SinOsc s => ADSR e => dac;

// set gain
.5 => s.gain;
Std.mtof(74) => s.freq;

[66, 68, 70, 66] @=> int notes[];

fun void melody()
{
  for (0 => int i; i < notes.cap(); i++)
  {
    s.freq(Std.mtof(notes[i]));
    e.keyOn();
    500::ms => now;
    e.keyOff();
    500::ms => now;
  }
}

fun void play(dur a, dur d, float s, dur r)
{
  <<< a, d, s, r >>>;
  e.set(a, d, s, r);
  melody();
}

play(25::ms, 50::ms, 0.01, 100::ms);
play(2::ms, 400::ms, 0.1, 20::ms);
play(10::ms, 8::ms, .5, 500::ms);
play(200::ms, 200::ms, .4, 200::ms);

1::second => now;
<<< "Random time!" >>>;

while (true)
{
  play(Math.random2(1,100)::ms, Math.random2(1,500)::ms, Math.random2f(0, 1.0), Math.random2(1,500)::ms);
}


