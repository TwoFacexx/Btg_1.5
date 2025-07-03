randomize();  
// Inicializa o gerador de números aleatórios  
// Initializes the random number generator

global.transicao = false;  
// Flag para indicar se está em transição  
// Flag indicating if a transition is happening

global.max_vida = 3;  
// Vida máxima do jogador  
// Player's maximum health/lives

global.vida = global.max_vida;  
// Vida atual começa na vida máxima  
// Current health starts at max health

/// Função para mudar o sprite do objeto  
/// Function to change the object's sprite  
function mudando_sprite(_sprite)  
{
    image_speed = 1;  
    // Velocidade da animação do sprite  
    // Sprite animation speed
    
    // Checar se eu estou com a sprite certa  
    // Check if we are already using the correct sprite  
    if (sprite_index != _sprite)  
    {
        sprite_index = _sprite;  
        // Muda o sprite  
        // Change the sprite
        
        image_index = 0;  
        // Reinicia a animação  
        // Restart animation frame
    }
}

global.novo_jogo_flag = false;  
// Flag que indica se está a começar um novo jogo  
// Flag indicating if a new game is starting

// Variáveis de save/load  
// Save/load variables
global.moedas_total = 0;  
global.porcos_mortos_total = 0;  
global.pontos_record = 0;  
global.mortes_total = 0;  
global.tempo_total_jogado = 0;  
global.nivel_atual = 1;  

// Variáveis de configuração  
// Configuration variables
global.volume_master = 1;  
global.volume_sfx = 1;  
global.volume_musica = 1;  

// Variáveis de sessão (não salvas)  
// Session variables (not saved)
global.moedas_sessao = 0;  
global.porcos_sessao = 0;  
global.tempo_sessao = 0;  
