ja_contou_morte = false; 
// Variável de controlo para garantir que só conta a morte uma vez
// Control variable to ensure death is only counted once

event_inherited(); 
// Isso vai executar o Create do obj_inimigo_pai (herança)
// This will execute the Create event of obj_inimigo_pai (inheritance)

visao = 100; 
// Alcance da visão do inimigo (em pixels)
// Enemy's vision range (in pixels)

estado = "idle"; 
// Estado inicial: parado (pode ser idle, run, pega, joga)
// Initial state: idle (can be idle, run, pega = grab, joga = throw)

vel = 1; 
// Velocidade base do inimigo
// Enemy's base speed

tempo_estado = room_speed * 1; 
// Duração do estado atual em steps (1 segundo)
// Current state duration in steps (1 second)

timer_estado = tempo_estado; 
// Timer que vai ser decrementado para mudar o estado
// Timer to be decreased to change the state

tomei_dano = false; 
// Marcar se já levou dano ou não
// Flag to track if damage was already taken

ver_o_player = function() 
{
    // Verifica se o jogador está na linha de visão do inimigo
    // Checks if the player is in the enemy's line of sight
    var _vi_player = collision_line(x, y - 14, x + visao * image_xscale, y - 14, obj_player, false, true);
    
    if (_vi_player)
    {
        estado = "joga"; 
        // Se vir o jogador, muda o estado para 'jogar' (vai lançar a bomba)
        // If player is seen, change state to 'throw' (enemy will throw the bomb)
    }
}
