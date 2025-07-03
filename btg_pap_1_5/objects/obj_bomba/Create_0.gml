// Herdar o evento do pai
// Inherit the parent event
event_inherited();

// Estado da bomba: pode ser "off" (inativa), "on" (ativa), ou "boom" (a explodir)
// Bomb state: can be "off", "on" (active), or "boom" (exploding)
momento = "off";

// Tempo até explodir (3 segundos)
// Timer until explosion (3 seconds)
boom_tempo = room_speed * 3;
boom_timer = boom_tempo;
