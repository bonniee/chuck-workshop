SinOsc osc => Envelope e => dac;
500::ms => dur QUARTER;

fun void note(int f, dur d)
{
  Std.mtof(f) => osc.freq;
  e.keyOn();
  d => now;
  e.keyOff();
  20::ms => now;
}

note(55, QUARTER / 2);
note(55, QUARTER / 2);
note(55, QUARTER / 2);
note(52, QUARTER * 4);
QUARTER / 2 => now;
note(53, QUARTER / 2);
note(53, QUARTER / 2);
note(53, QUARTER / 2);
note(50, QUARTER * 4);

