// Controlando o player
// Controlling the player
var _chao = place_meeting(x, y + 1, obj_chao); 
// Verifica se o player está em contato com o chão (posição um pixel abaixo)
// Checks if the player is standing on the ground (one pixel below)

// Verifica se o jogo está pausado através do objeto de pausa
// Checks if the game is paused through the pause manager object
if (instance_exists(obj_pause_manager) && obj_pause_manager.pausado) {
    exit; // Não processa input do player se o jogo estiver pausado
    // Don't process player input if the game is paused
}

switch(estado)
{
    case "normal":
        estado_normal();  // Chama a função que trata o estado normal do jogador
        // Calls the function that handles the normal player state
    break;
    
    case "in":
        // Termina a animação de entrada do player e pausa nela
        // Ends the player's "in" animation and pauses on the last frame
        var _img_vel = sprite_get_speed(sprite_index) / room_speed;
        // Velocidade da animação relativa ao room_speed
        // Animation speed relative to room_speed

        // Se a animação está quase no fim
        // If the animation is almost finished
        if (image_index > image_number - _img_vel)
        {
            image_speed = 0;     // Para animação
            image_index = image_number - 1;  // Fixa no último frame
            image_alpha = 0;     // Torna o sprite invisível (fade out)
        }
    break;
    
    case "out":
        mudando_sprite(spr_player_out);  // Muda o sprite para o sprite de saída
        
        var _img_vel = sprite_get_speed(sprite_index) / room_speed;
        // Se a animação de saída está quase no fim, troca para estado "normal"
        if (image_index > image_number - _img_vel)
        {
            estado = "normal";  // Volta para estado normal
        }
    break;
    
    case "dead":
        mudando_sprite(spr_player_dead);  // Troca sprite para o sprite de morte
        audio_stop_all();                  // Para todos os sons

        // Ativa o game over apenas uma vez
        if (!obj_game_control.game_over) {
            obj_game_control.game_over = true;
        }
        
        if (modo_reinicio == "manual") {
            // Modo manual: reinicia o jogo somente ao pressionar ENTER
            if (keyboard_check_pressed(vk_enter)) {
                global.vida = global.max_vida;  // Restaura vida do jogador
                game_restart();                  // Reinicia o jogo
            }
        }
        
        // Efeito visual de fade in do sprite da morte
        if (image_alpha < 1) {
            image_alpha += 0.01;  // Aumenta lentamente a opacidade
        }
        
        // Para a animação no último frame da sprite de morte
        if (image_index > image_number - 1) {
            image_speed = 0;
            image_index = image_number - 1;
        }
    break;
}
