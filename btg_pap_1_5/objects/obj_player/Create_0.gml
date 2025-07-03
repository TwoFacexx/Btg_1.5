// Velocidades e física
velh        = 0;           // Velocidade horizontal
velv        = 0;           // Velocidade vertical
vel         = 2.5;         // Velocidade base de movimento horizontal
grav        = 0.3;         // Gravidade aplicada verticalmente
vel_jump    = 6.3;         // Velocidade inicial do salto

// Variáveis de dano e invencibilidade
posso_perder_vida = true;  // Flag para saber se o jogador pode perder vida (invencibilidade temporária)
dano        = false;       // Flag para estado de dano (se o jogador está a levar dano)
tempo_dano  = room_speed * 0.5;  // Duração do tempo em que o jogador está "tomando dano"
timer_dano  = 0;           // Timer para controlar o tempo de dano

// Variáveis para reinício
tempo_reinicia = room_speed * 3;
timer_reinicia = tempo_reinicia;

// Variáveis para invencibilidade após dano
inv_tempo   = room_speed * 2;    // Duração da invencibilidade
inv_timer   = 0;                 // Timer para invencibilidade

// Estado inicial do jogador
estado      = "out";
sprite_index = spr_player_out;
image_speed = 0;

// Se não estamos na tela inicial, cria a animação de transição de saída da porta
if (room != rm_tela_inicial)
{
    layer_sequence_create("Transicao", x, y, sq_transicao_out);
}

// Configuração dos inputs do jogador
inputs  = {
    left    : ord("A"),
    right   : ord("D"),
    jump    : vk_space
}

// Função principal para estado normal do jogador
estado_normal = function()
{
    image_speed = 1;  // Velocidade da animação ligada
    
    var _chao = place_meeting(x, y + 1, obj_chao); // Verifica se está no chão
    var _left, _right, _jump;
    
    _left   = keyboard_check(inputs.left);
    _right  = keyboard_check(inputs.right);
    _jump   = keyboard_check_pressed(inputs.jump);

    // Só permite controlar se não está a tomar dano
    if (timer_dano <= 0)
    {
        velh = (_right - _left) * vel;  // Movimento horizontal (1, 0 ou -1 multiplicado pela velocidade)
    }

    // Saltar
    if (_chao)
    {
        if (_jump)
        {
            velv = -vel_jump;          // Aplica velocidade de salto para cima (negativo no eixo Y)
            audio_stop_sound(som_passos);
            tocar_som(som_pulo, 5, false);
        }

        // Se no chão e a mover-se
        if (velh != 0)
        {
            sprite_index = spr_player_run;       // Muda sprite para correr
            image_xscale = sign(velh);           // Espelha sprite para o lado correto

            if (!audio_is_playing(som_passos)) {
                tocar_som(som_passos, 3, true);  // Toca som de passos se não estiver a tocar
            }
        }
        else
        {
            sprite_index = spr_player_idle;      // Sprite parado
            audio_stop_sound(som_passos);        // Para som de passos
        }
    }
    else // No ar
    {
        if (velv < 0)
        {
            audio_stop_sound(som_passos);
            sprite_index = spr_player_jump;      // Sprite de salto
        }
        else
        {
            sprite_index = spr_player_fall;      // Sprite de queda

            // Verifica se caiu na cabeça do inimigo
            var _inimigo = instance_place(x, y + 5, obj_inimigo_pai);

            if (_inimigo)
            {
                dano = false;
                if (_inimigo.morto == false)
                {
                    tocar_som(som_hit_porco, 7, false);
                    velv = -vel_jump;             // Salta de novo após bater no inimigo
                    _inimigo.dano = true;        // Marca inimigo como danificado
                }
            }
        }

        // Aplica gravidade sempre no ar
        velv += grav;

        if (velh != 0)
        {
            image_xscale = sign(velh); // Ajusta orientação no ar
        }
    }

    // Estado de dano do jogador
    if (dano)
    {
        sprite_index = spr_player_hit;  // Sprite de dano
        velh = 0;                      // Para movimento

        if (posso_perder_vida)
        {
            global.vida--;

            if (global.vida <= 0)
            {
                estado = "dead";       // Passa para estado morto
            }
            else
            {
                posso_perder_vida = false; // Invencibilidade temporária ativada
            }
        }
    }

    // Atualiza timer de dano
    if (timer_dano > 0)
    {
        timer_dano--;
    }
    else
    {
        dano = false;
        posso_perder_vida = true;
    }

    // Atualiza timer de invencibilidade visual (piscar)
    if (inv_timer > 0)
    {
        inv_timer--;
        image_alpha = 0.5;
    }
    else
    {
        image_alpha = 1;
    }

    // Detecta colisão com inimigo para tomar dano (se não estiver invencível)
    var _inimigo = instance_place(x, y, obj_inimigo_pai);
    if (_inimigo && inv_timer <= 0)
    {
        if (_inimigo.morto == false && _inimigo.dano == false)
        {
            dano = true;
            timer_dano = tempo_dano;   // Ativa timer de dano
            inv_timer = inv_tempo;     // Ativa invencibilidade temporária
        }
    }
}
modo_reinicio = "manual";  // Define o modo de reinício do jogo como manual (o jogador decide quando reiniciar)
