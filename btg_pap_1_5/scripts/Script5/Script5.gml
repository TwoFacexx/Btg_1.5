/// @function criar_particulas(x, y, quantidade, cor)
function criar_particulas(_x, _y, _quantidade = 10, _cor = -1) {
    repeat(_quantidade) {
        var _part = instance_create_layer(_x, _y, "Instances", obj_particula);
        
        // Se uma cor foi especificada, aplica-a à partícula
        // If a color is specified, apply it to the particle
        if (_cor != -1) {
            _part.image_blend = _cor;
        }
        
        // Adiciona variação aleatória na posição X e Y para dispersar as partículas
        // Adds random variation to X and Y position to spread particles around
        _part.x += random_range(-8, 8);
        _part.y += random_range(-8, 8);
    }
}

// Versão específica para morte de porco
// Specific version for pig death particles
function criar_particulas_porco(_x, _y) {
    repeat(15) {
        var _part = instance_create_layer(_x, _y - 16, "Instances", obj_particula);
        
        // Escolhe uma cor aleatória entre branco, vermelho ou marrom para a partícula
        // Chooses a random color among white, red, or maroon for the particle
        _part.image_blend = choose(c_white, c_red, c_maroon);
        
        // Define a direção da partícula entre 60 e 120 graus para dispersão
        // Sets particle direction between 60 and 120 degrees for spread
        _part.direction = random_range(60, 120);
        
        // Define a velocidade da partícula entre 3 e 7
        // Sets particle speed between 3 and 7
        _part.speed = random_range(3, 7);
    }
}

// Versão para explosão de bomba
// Version for bomb explosion particles
function criar_particulas_explosao(_x, _y) {
    repeat(25) {
        var _part = instance_create_layer(_x, _y, "Instances", obj_particula);
        
        // Escolhe uma cor entre laranja, amarelo, vermelho e branco para a explosão
        // Chooses a color among orange, yellow, red, and white for the explosion
        _part.image_blend = choose(c_orange, c_yellow, c_red, c_white);
        
        // Direção aleatória em 360 graus para espalhar as partículas em todas direções
        // Random direction over 360 degrees to spread particles all around
        _part.direction = random(360);
        
        // Velocidade da partícula entre 4 e 8
        // Particle speed between 4 and 8
        _part.speed = random_range(4, 8);
        
        // Menor gravidade para a partícula flutuar um pouco
        // Lower gravity so the particle floats a bit
        _part.gravity = 0.1;
        
        // Escala aleatória para tamanho da partícula
        // Random scale for particle size
        _part.image_xscale = random_range(0.5, 1.2);
        _part.image_yscale = _part.image_xscale;
    }
}

// Versão para coletar moeda
// Version for coin collection particles
function criar_particulas_moeda(_x, _y) {
    repeat(8) {
        var _part = instance_create_layer(_x, _y, "Instances", obj_particula);
        
        // Escolhe uma cor relacionada a moedas (amarelo, dourado, branco)
        // Chooses a coin-related color (yellow, gold, white)
        _part.image_blend = choose(c_yellow, c_gold, c_white);
        
        // Direção aleatória para dispersão natural
        // Random direction for natural spread
        _part.direction = random(360);
        
        // Velocidade baixa para efeito suave
        // Low speed for a gentle effect
        _part.speed = random_range(1, 3);
        
        // Sem gravidade para as partículas não caírem
        // No gravity so particles don't fall
        _part.gravity = 0;
        
        // Transparência semi-opaca para efeito visual agradável
        // Semi-transparent for a nice visual effect
        _part.image_alpha = 0.8;
    }
}
