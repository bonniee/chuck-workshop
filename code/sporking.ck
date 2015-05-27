// Demonstrates sporking.

SinOsc beatOsc => Envelope e => dac;
40 => beatOsc.freq;

100::ms => dur QUARTER;

fun void beat(dur d, int f)
{
  e.keyOn();
  d => now;
  f => beatOsc.freq;
  e.keyOff();
}

fun void beatForever()
{
  while(true)
  {
    2 => float m;
    beat(QUARTER * m, 80);
    QUARTER * m => now;
    beat(QUARTER * m, 100);
    QUARTER * m => now;
  }
}

SinOsc melody => Envelope e2 => dac;
0.1 => e2.gain;
fun void note(float f, int beats)
{
  f => melody.freq;
  e2.keyOn();
  (beats * QUARTER) => now;
  e2.keyOff();
  (beats * QUARTER) => now;
}

fun void playMelody()
{
  while(true)
  {
    note(440, 1);
    note(440, 1);
    note(330, 1);
    note(550, 1);
  }
}

spork ~ playMelody();
spork ~ beatForever();


while(true) {
  1::second => now;
}
