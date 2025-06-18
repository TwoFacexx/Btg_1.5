// Configuração visual
image_speed = 0; // Sem animação
image_alpha = 1;

// Cor aleatória
image_blend = choose(c_white, c_red, c_orange, c_yellow);

// Tamanho aleatório
var _scale = random_range(0.3, 0.8);
image_xscale = _scale;
image_yscale = _scale;

// Movimento
direction = random_range(45, 135); // Para cima
speed = random_range(2, 5);
gravity = 0.3;
gravity_direction = 270; // Para baixo

// Rotação aleatória
image_angle = random(360);
rot_speed = random_range(-10, 10);

// Tempo de vida
alarm[0] = random_range(20, 40); // 0.3 a 0.6 segundos