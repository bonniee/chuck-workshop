SinOsc osc => Envelope e => dac;
TriOsc to => e;
TriOsc to2 => e;
to.gain(0.3);
to2.gain(0.1);
osc.gain(1);

500 => int Q;

fun void play(int f, dur d)
{
  Std.mtof(f) => osc.freq;
  Std.mtof(f) / 2 => to.freq;
  Std.mtof(f) * 2 => to2.freq;
  e.keyOn();
  d => now;
  e.keyOff();
  20::ms => now;
}

[ [55,Q/2], [55,Q/2], [55,Q/2], [52,Q*2],
  [0,Q/2], [53,Q/2], [53, Q/2], [53,Q/2],
  [50,Q*2] ] @=> int notes[][];

for (0 => int i; i < notes.cap(); i++)
{
  play(notes[i][0], notes[i][1]::ms);
}
