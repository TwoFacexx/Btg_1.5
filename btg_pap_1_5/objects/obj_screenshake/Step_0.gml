// tremendo
// shaking
view_xport[0] = random_range(-shake, shake);
// Define a posição horizontal da viewport aleatoriamente dentro do intervalo de -shake a +shake
// Sets the horizontal viewport position randomly within -shake to +shake

view_yport[0] = random_range(-shake, shake);
// Define a posição vertical da viewport aleatoriamente dentro do intervalo de -shake a +shake
// Sets the vertical viewport position randomly within -shake to +shake

shake *= 0.95;
// Diminui gradualmente o valor de shake para suavizar o efeito de tremor
// Gradually reduces the shake value to smooth the shaking effect

// destruindo
// destroying
if (shake <= 0.2)
{
    instance_destroy(); 
    // Destrói a instância quando o shake estiver quase acabado
    // Destroys the instance when the shake effect is almost finished
}
