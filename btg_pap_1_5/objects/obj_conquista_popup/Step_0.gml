// Animação de entrada (fade in + descer)
// Entry animation (fade in + move down)
if (fade_in) {
    alpha = lerp(alpha, 1, 0.1);      // Aumentar opacidade // Increase opacity
    y_offset = lerp(y_offset, 0, 0.15); // Aproximar do alvo // Move toward target

    if (alpha > 0.9) {
        fade_in = false; // Passar para a fase de espera // Switch to waiting phase
    }
}

// Contagem para desaparecer
// Countdown to disappear
timer--;
if (timer <= 0) {
    alpha = lerp(alpha, 0, 0.05); // Fade out

    if (alpha < 0.1) {
        instance_destroy(); // Destruir popup // Destroy popup
    }
}
