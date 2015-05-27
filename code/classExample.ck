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

