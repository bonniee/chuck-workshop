// Variables
42 => int answer;
525600::minute => dur year;

// Functions
fun void hey(string s)
{
  <<< "hello ", s, "!" >>>;
}

hey("everyone");

// Arrays
int notes[10]; // Initialized to 0s
[55, 57, 59, 55, 55, 57, 59, 55] @=> int fjNotes[];

// dac
SinOsc o => dac;

// Loops
for (0 => int i; i < fjNotes.cap(); i++) {
  Std.mtof(fjNotes[i]) => o.freq;
  200::ms => now;
}

100::ms => now;

while(true)
{
  Std.mtof(Std.rand2f(60,70)) => o.freq;
  100::ms => now;
}

