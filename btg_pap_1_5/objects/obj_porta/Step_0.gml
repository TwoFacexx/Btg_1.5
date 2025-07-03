// Se está rolando uma transição, não faz nada
// If a transition is in progress, do nothing
if (global.transicao != false) exit;

switch(estado)
{
    case "idle":
        sprite_index = spr_porta;  // Sprite da porta parada (idle)
        image_speed  = 1;           // Animação normal
        
        // Verifica se o player está colidindo com a porta
        // Check if the player is colliding with the door
        var _player = instance_place(x, y, obj_player);
        if (_player)
        {
            // Checa se o player pressionou a tecla "W" (seta para cima) e se a saída está ativa
            // Check if player pressed "W" (up arrow) and if exit is active
            if (keyboard_check_pressed(ord("W")) && saida)
            {
                estado = "abrindo";     // Muda o estado para "abrindo"
                
                // Coloca o player no estado "in" para iniciar a animação de entrar
                // Set player state to "in" to start entering animation
                _player.estado = "in";
            }
        }
    break;
    
    case "abrindo":
        mudando_sprite(spr_porta_abre);  // Troca o sprite para porta abrindo
        
        // Toca o som da porta abrindo logo no início da animação
        if (image_index < 1 && sprite_index == spr_porta_abre) {
            tocar_som(som_porta_abrindo, 5, false);
        }
        
        // Quando a animação terminar de abrir, para no último frame
        if (image_index >= image_number - 1)
        {
            image_speed = 0; // Para animação
            
            // Cria a transição visual da porta abrindo na posição do player
            layer_sequence_create("Transicao", obj_player.x, obj_player.y, sq_transicao_in);
        }
        
        // Ao completar nível, incrementa nível atual e salva progresso
        global.nivel_atual++;
        save_update_stat("nivel_atual", global.nivel_atual, false);
        save_game(); // Salva progresso ao passar de fase
    break;
    
    case "fechando":
        mudando_sprite(spr_porta_fecha); // Troca sprite para porta fechando
        
        // Quando a animação de fechar termina, toca som e volta ao estado "idle"
        if (image_index >= image_number - 1)
        {
            tocar_som(som_porta_fechando, 5, false);
            estado = "idle";  // Volta ao estado parado
        }
    break;
}