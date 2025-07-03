// Configuração visual  
// Visual configuration  
image_speed = 0;  
// pt-PT: Animação da imagem parada (sem animação)  
// EN: Image animation stopped (no animation)  

image_alpha = 1;  
// pt-PT: Opacidade total da imagem (completamente visível)  
// EN: Full opacity of the image (fully visible)  

image_blend = choose(c_white, c_red, c_orange, c_yellow);  
// pt-PT: Escolhe aleatoriamente uma cor para misturar com a imagem  
// EN: Randomly chooses a color to blend with the image  

// Tamanho aleatório  
// Random size  
var _scale = random_range(0.3, 0.8);  
image_xscale = _scale;  
image_yscale = _scale;  
// pt-PT: Define escala horizontal e vertical aleatória para a imagem  
// EN: Sets random horizontal and vertical scale for the image  

// Movimento usando velh/velv ao invés de speed/direction  
// Movement using velh/velv instead of speed/direction  
velh = random_range(-3, 3);  
velv = random_range(-5, -2); // Para cima  
// pt-PT: Velocidades horizontais e verticais aleatórias, velv para cima (negativo)  
// EN: Random horizontal and vertical velocities, velv going up (negative)  

grav = 0.15; // Gravidade personalizada  
// pt-PT: Valor da gravidade aplicada ao movimento vertical  
// EN: Gravity value applied to vertical movement  

// Rotação  
// Rotation  
image_angle = random(360);  
rot_speed = random_range(-10, 10);  
// pt-PT: Ângulo inicial e velocidade de rotação aleatória  
// EN: Initial angle and random rotation speed  

// Tempo de vida  
// Lifetime  
vida_maxima = random_range(30, 60);  
vida_atual = vida_maxima;  
// pt-PT: Define a vida máxima e atual da entidade (em frames)  
// EN: Sets the maximum and current lifetime of the entity (in frames)  
