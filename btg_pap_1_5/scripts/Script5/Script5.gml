/// @function criar_particulas(x, y, quantidade, cor)
function criar_particulas(_x, _y, _quantidade = 10, _cor = -1) {
    repeat(_quantidade) {
        var _part = instance_create_layer(_x, _y, "Instances", obj_particula);
        
        // Se uma cor foi especificada
        if (_cor != -1) {
            _part.image_blend = _cor;
        }
        
        // Adicionar variação na posição
        _part.x += random_range(-8, 8);
        _part.y += random_range(-8, 8);
    }
}

// Versão específica para morte de porco
function criar_particulas_porco(_x, _y) {
    repeat(15) {
        var _part = instance_create_layer(_x, _y - 16, "Instances", obj_particula);
        _part.image_blend = choose(c_white, c_red, c_maroon);
        _part.direction = random_range(60, 120);
        _part.speed = random_range(3, 7);
    }
}

// Versão para explosão de bomba
function criar_particulas_explosao(_x, _y) {
    repeat(25) {
        var _part = instance_create_layer(_x, _y, "Instances", obj_particula);
        _part.image_blend = choose(c_orange, c_yellow, c_red, c_white);
        _part.direction = random(360); // Todas direções
        _part.speed = random_range(4, 8);
        _part.gravity = 0.1; // Menos gravidade
        _part.image_xscale = random_range(0.5, 1.2);
        _part.image_yscale = _part.image_xscale;
    }
}

// Versão para coletar moeda
function criar_particulas_moeda(_x, _y) {
    repeat(8) {
        var _part = instance_create_layer(_x, _y, "Instances", obj_particula);
        _part.image_blend = choose(c_yellow, c_gold, c_white);
        _part.direction = random(360);
        _part.speed = random_range(1, 3);
        _part.gravity = 0;
        _part.image_alpha = 0.8;
    }
}