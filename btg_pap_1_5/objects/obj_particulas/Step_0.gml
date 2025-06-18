// Rotacionar
image_angle += rot_speed;

// Diminuir alpha gradualmente
image_alpha -= 0.02;

// Destruir se invisível
if (image_alpha <= 0) {
    instance_destroy();
}