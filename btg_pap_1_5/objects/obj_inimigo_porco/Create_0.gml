// Herda o evento do pai
// Inherit the parent event
event_inherited();

// Flag para contar a morte só uma vez
// Flag to count death only once
ja_contou_morte = false;

// Personalizando variáveis
// Customizing variables

// Decide se pode andar para a direita ou para a esquerda
// Decides if it can walk right or left
vel = choose(1, -1);

// Estado inicial
// Initial state
estado = "normal";

// Se pode pegar bomba
// If it can pick up bomb
pega_bomba = true;

// Se está andando
// If it is walking
andando = choose(true, false);

if (andando)
{
    // Decide a velocidade horizontal (velh) com base em 'vel'
// Decide horizontal velocity (velh) based on 'vel'
    velh = choose(vel, -vel);
}
else
{
    // Se não andando, velocidade horizontal é zero
// If not walking, horizontal velocity is zero
    velh = 0;
}

// Tempo para decidir andar (em passos)
// Time to decide walking (in steps)
tempo_decidir_andar = room_speed * 3;
