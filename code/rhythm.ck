SinOsc osc => dac;
osc.gain(0);

fun void play(int len)
{
  osc.gain(1);
  len::ms => now;
  osc.gain(0);
}

fun void wait(int len)
{
  len::ms => now;
}

200 => int Q;

while (true)
{
  play(Q);
  wait(Q);
  play(Q/2);
  wait(Q/2);
  play(Q);
  wait(Q/2);
}

